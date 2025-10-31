import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:multitasking/app/assets/images.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';
import 'package:multitasking/app/log/logger_service_impl.dart';
import 'package:multitasking/app/theme/app_colors.dart';

class OverlayFramePage extends StatefulWidget {
  const OverlayFramePage({super.key});

  @override
  State<OverlayFramePage> createState() => _OverlayFramePageState();
}

class _OverlayFramePageState extends State<OverlayFramePage> {
  // kích thước cơ bản của khung
  double baseWidth = 120;
  double baseHeight = 120;

  // trạng thái biến đổi
  Offset frameOffset = Offset.zero; // độ lệch so với tâm màn hình
  double scaleFactor = 1.0;

  // biến hỗ trợ cho cử chỉ
  late Offset _initialFocal;
  late Offset _initialOffset;
  late double _initialScale;
  bool _scaleActive = false;
  String? _activeCorner; // 'tl', 'tr', 'bl', 'br' hoặc null

  final GlobalKey _captureKey = GlobalKey();
  Rect? _lastCaptureRectPx; // vùng khung (pixel) trên bitmap đã capture
  ui.Image? _lastCapturedImage; // ảnh chụp gần nhất
  bool _showPreview = false; // hiển thị preview nhỏ

  _handleReset() {
    setState(() {
      frameOffset = Offset.zero;
      scaleFactor = 1.0;
    });
  }

  Future<void> _handleDownloadImage(Rect clamped) async {
    try {
      final boundary =
          _captureKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      final dpr = MediaQuery.of(context).devicePixelRatio;
      final ui.Image image = await boundary.toImage(pixelRatio: dpr);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData?.buffer.asUint8List();
      logger.d('Captured bytes length: ${bytes?.length}');
      setState(() {
        _lastCapturedImage = image;
        _showPreview = true;
      });
      _lastCaptureRectPx = Rect.fromLTWH(
        clamped.left * dpr,
        clamped.top * dpr,
        clamped.width * dpr,
        clamped.height * dpr,
      );
    } on PlatformException catch (e) {
      logger.e("Failed to capture view: ${e.message}");
    }
  }

  void _recalcCaptureRectPx({
    required double workAreaWidth,
    required double workAreaHeight,
    required Rect frameRectLocal,
  }) {
    // clamp khung trong workArea local
    final left = frameRectLocal.left.clamp(0.0, workAreaWidth);
    final top = frameRectLocal.top.clamp(0.0, workAreaHeight);
    final right = frameRectLocal.right.clamp(0.0, workAreaWidth);
    final bottom = frameRectLocal.bottom.clamp(0.0, workAreaHeight);
    final clamped = Rect.fromLTRB(left, top, right, bottom);
    _handleDownloadImage(clamped);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    // tính vùng làm việc sau khi trừ padding
    final topPad = context.pT * 2;
    final leftPad = context.paddingHorizontalM.left * 2;
    final rightPad = context.paddingHorizontalM.right * 2;
    final bottomPad = 200.0;

    final workAreaWidth = media.width - leftPad - rightPad;
    final workAreaHeight = media.height - topPad - bottomPad;

    // tâm địa phương của vùng làm việc (tọa độ local trong widget con sau padding)
    final center = Offset(workAreaWidth / 2, workAreaHeight / 2);

    // tính toán hình chữ nhật khung hiện tại (lấy tâm màn hình + độ lệch)
    final currentWidth = baseWidth * scaleFactor;
    final currentHeight = baseHeight * scaleFactor;
    final rectCenter = center + frameOffset;
    final frameRect = Rect.fromCenter(
      center: rectCenter,
      width: currentWidth,
      height: currentHeight,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          Positioned(
            top: context.viewPadding.top,
            left: context.paddingHorizontalM.left,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.close, color: AppColors.background),
            ),
          ),
          Positioned(
            top: context.viewPadding.top,
            right: context.paddingHorizontalM.left,
            child: IconButton(
              onPressed: () {
                _handleReset();
              },
              icon: Icon(Icons.autorenew, color: AppColors.background),
            ),
          ),
          if (_showPreview && _lastCapturedImage != null)
            Positioned(
              bottom: 16,
              right: 16,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomPaint(
                          size: const Size(140, 140),
                          painter: _CroppedImagePainter(
                            image: _lastCapturedImage!,
                            srcRect: _lastCaptureRectPx,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: InkWell(
                        onTap: () => setState(() => _showPreview = false),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Khu vực cần capture: gộp nền + overlay vào chung một RepaintBoundary
          Positioned.fill(
            child: Padding(
              padding: EdgeInsetsGeometry.only(
                top: context.pT * 2,
                right: context.paddingHorizontalM.right * 2,
                left: context.paddingHorizontalM.left * 2,
                bottom: 200,
              ),
              child: RepaintBoundary(
                key: _captureKey,
                child: Stack(
                  children: [
                    // nền
                    Positioned.fill(
                      child: Image.asset(ImagePath.bgSplash, fit: BoxFit.cover),
                    ),
                    // overlay + gesture
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onScaleStart: (details) {
                          // phát hiện gần 4 góc để resize
                          const cornerHit = 28.0;
                          final tl = frameRect.topLeft;
                          final tr = frameRect.topRight;
                          final bl = frameRect.bottomLeft;
                          final br = frameRect.bottomRight;

                          String? corner;
                          if ((details.localFocalPoint - tl).distance <=
                              cornerHit)
                            corner = 'tl';
                          else if ((details.localFocalPoint - tr).distance <=
                              cornerHit)
                            corner = 'tr';
                          else if ((details.localFocalPoint - bl).distance <=
                              cornerHit)
                            corner = 'bl';
                          else if ((details.localFocalPoint - br).distance <=
                              cornerHit)
                            corner = 'br';

                          _activeCorner = corner;

                          // kích hoạt khi bắt đầu trong khung hoặc gần góc
                          _scaleActive =
                              frameRect.contains(details.localFocalPoint) ||
                              _activeCorner != null;
                          if (_scaleActive) {
                            _initialFocal = details.localFocalPoint;
                            _initialOffset = frameOffset;
                            _initialScale = scaleFactor;
                          }
                        },
                        onScaleUpdate: (details) {
                          if (!_scaleActive) return;
                          // phóng to/thu nhỏ và di chuyển đồng thời
                          setState(() {
                            double newScale;
                            if (_activeCorner != null) {
                              // resize theo góc với neo cố định ở góc đối diện, giữ tỉ lệ gốc
                              // xác định neo và hướng dựa trên góc đang kéo
                              late Offset anchor;
                              late double signX;
                              late double signY;
                              if (_activeCorner == 'br') {
                                anchor = frameRect.topLeft;
                                signX = 1;
                                signY = 1;
                              } else if (_activeCorner == 'tr') {
                                anchor = frameRect.bottomLeft;
                                signX = 1;
                                signY = -1;
                              } else if (_activeCorner == 'bl') {
                                anchor = frameRect.topRight;
                                signX = -1;
                                signY = 1;
                              } else {
                                // 'tl'
                                anchor = frameRect.bottomRight;
                                signX = -1;
                                signY = -1;
                              }

                              // vector từ neo đến điểm chạm hiện tại
                              final delta = details.localFocalPoint - anchor;
                              final dx = (delta.dx * signX).abs();
                              final dy = (delta.dy * signY).abs();

                              // tỉ lệ mong muốn theo từng trục và lấy nhỏ nhất để không vượt quá
                              final kx = dx / baseWidth;
                              final ky = dy / baseHeight;
                              double k = kx < ky ? kx : ky;

                              // giới hạn k theo biên vùng làm việc với neo cố định và padding an toàn
                              const double pad = 0;
                              final workRight = workAreaWidth;
                              final workBottom = workAreaHeight;
                              double maxKX;
                              double maxKY;
                              if (signX > 0) {
                                maxKX =
                                    (workRight - pad - anchor.dx) / baseWidth;
                              } else {
                                maxKX = (anchor.dx - pad) / baseWidth;
                              }
                              if (signY > 0) {
                                maxKY =
                                    (workBottom - pad - anchor.dy) / baseHeight;
                              } else {
                                maxKY = (anchor.dy - pad) / baseHeight;
                              }
                              final maxK = maxKX < maxKY ? maxKX : maxKY;
                              // clamp cuối cùng theo anchor và ngưỡng tổng quát
                              // sẽ còn bị chặn bởi kích thước màn hình bên dưới
                              k = k.clamp(0.1, maxK.clamp(0.1, 3.0));

                              newScale = k;
                            } else {
                              // pinch thông thường
                              newScale = (_initialScale * details.scale);
                            }

                            // chặn theo kích thước vùng làm việc với padding an toàn
                            const double pad = 0;
                            final availW = workAreaWidth - 2 * pad;
                            final availH = workAreaHeight - 2 * pad;
                            final maxScaleByScreen = math.min(
                              availW / baseWidth,
                              availH / baseHeight,
                            );
                            final maxAllowed = maxScaleByScreen.isFinite
                                ? maxScaleByScreen.clamp(0.1, 3.0)
                                : 3.0;
                            if (maxAllowed < 0.5) {
                              newScale = maxAllowed.toDouble();
                            } else {
                              newScale = newScale.clamp(
                                0.5,
                                maxAllowed.toDouble(),
                              );
                            }

                            // pan (khi không resize góc) hoặc pinch move: cập nhật offset
                            Offset nextOffset;
                            if (_activeCorner != null) {
                              // khi resize theo góc với neo đối diện, tính tâm từ neo và kích thước mới
                              late Offset anchor;
                              if (_activeCorner == 'br')
                                anchor = frameRect.topLeft;
                              else if (_activeCorner == 'tr')
                                anchor = frameRect.bottomLeft;
                              else if (_activeCorner == 'bl')
                                anchor = frameRect.topRight;
                              else
                                anchor = frameRect.bottomRight; // 'tl'

                              final newWidth = baseWidth * newScale;
                              final newHeight = baseHeight * newScale;
                              // xác định góc đang kéo theo anchor + vector (signX, signY)
                              late double signX;
                              late double signY;
                              if (_activeCorner == 'br') {
                                signX = 1;
                                signY = 1;
                              } else if (_activeCorner == 'tr') {
                                signX = 1;
                                signY = -1;
                              } else if (_activeCorner == 'bl') {
                                signX = -1;
                                signY = 1;
                              } else {
                                signX = -1;
                                signY = -1;
                              }

                              final draggedCorner = Offset(
                                anchor.dx + signX * newWidth,
                                anchor.dy + signY * newHeight,
                              );
                              final newCenter = Offset(
                                (anchor.dx + draggedCorner.dx) / 2,
                                (anchor.dy + draggedCorner.dy) / 2,
                              );
                              nextOffset = newCenter - center;
                            } else {
                              nextOffset =
                                  _initialOffset +
                                  (details.localFocalPoint - _initialFocal);
                            }

                            // giới hạn để khung luôn nằm trong biên vùng làm việc (có chừa padding)
                            final newWidth = baseWidth * newScale;
                            final newHeight = baseHeight * newScale;
                            final minCenterX = newWidth / 2 + pad;
                            final maxCenterX =
                                workAreaWidth - newWidth / 2 - pad;
                            final minCenterY = newHeight / 2 + pad;
                            final maxCenterY =
                                workAreaHeight - newHeight / 2 - pad;

                            final tentativeCenter = center + nextOffset;
                            // đảm bảo tham số clamp hợp lệ ngay cả khi min > max
                            final safeMinX = math.min(minCenterX, maxCenterX);
                            final safeMaxX = math.max(minCenterX, maxCenterX);
                            final safeMinY = math.min(minCenterY, maxCenterY);
                            final safeMaxY = math.max(minCenterY, maxCenterY);

                            final clampedCenter = Offset(
                              tentativeCenter.dx.clamp(safeMinX, safeMaxX),
                              tentativeCenter.dy.clamp(safeMinY, safeMaxY),
                            );

                            scaleFactor = newScale;
                            frameOffset = clampedCenter - center;
                          });
                        },
                        onScaleEnd: (_) {
                          _scaleActive = false;
                          _activeCorner = null;
                          // tính lại vùng khung theo pixel để cover bitmap
                          _recalcCaptureRectPx(
                            workAreaWidth: workAreaWidth,
                            workAreaHeight: workAreaHeight,
                            frameRectLocal: frameRect,
                          );
                        },
                        onDoubleTap: () {},
                        child: CustomPaint(
                          painter: _OverlayPainter(
                            frameRect: frameRect,
                            cornerRadius: 18.0,
                            bracketLength: 28.0,
                            bracketStroke: 6.0,
                          ),
                          child: Container(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter draws:
/// - full-screen translucent black except for a rounded rect "hole"
/// - a white border around the hole
/// - 4 corner brackets
class _OverlayPainter extends CustomPainter {
  final Rect frameRect;
  final double cornerRadius;
  final double bracketLength;
  final double bracketStroke;

  _OverlayPainter({
    required this.frameRect,
    this.cornerRadius = 16.0,
    this.bracketLength = 28.0,
    this.bracketStroke = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()..color = Colors.black.withOpacity(0.6);

    // full screen path
    final full = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // rounded rect path for transparent hole
    final rrect = RRect.fromRectAndRadius(
      frameRect,
      Radius.circular(cornerRadius),
    );
    final hole = Path()..addRRect(rrect);

    // difference: overlay minus hole
    final diff = Path.combine(PathOperation.difference, full, hole);
    canvas.drawPath(diff, overlayPaint);

    // draw white border around hole (thin)
    final borderPaint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rrect, borderPaint);

    // draw corner brackets (thicker)
    final bracketPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = bracketStroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double L = bracketLength;
    // top-left
    canvas.drawLine(
      frameRect.topLeft,
      frameRect.topLeft + Offset(L, 0),
      bracketPaint,
    );
    canvas.drawLine(
      frameRect.topLeft,
      frameRect.topLeft + Offset(0, L),
      bracketPaint,
    );
    // top-right
    canvas.drawLine(
      frameRect.topRight,
      frameRect.topRight + Offset(-L, 0),
      bracketPaint,
    );
    canvas.drawLine(
      frameRect.topRight,
      frameRect.topRight + Offset(0, L),
      bracketPaint,
    );
    // bottom-left
    canvas.drawLine(
      frameRect.bottomLeft,
      frameRect.bottomLeft + Offset(L, 0),
      bracketPaint,
    );
    canvas.drawLine(
      frameRect.bottomLeft,
      frameRect.bottomLeft + Offset(0, -L),
      bracketPaint,
    );
    // bottom-right
    canvas.drawLine(
      frameRect.bottomRight,
      frameRect.bottomRight + Offset(-L, 0),
      bracketPaint,
    );
    canvas.drawLine(
      frameRect.bottomRight,
      frameRect.bottomRight + Offset(0, -L),
      bracketPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _OverlayPainter old) {
    return old.frameRect != frameRect ||
        old.cornerRadius != cornerRadius ||
        old.bracketLength != bracketLength ||
        old.bracketStroke != bracketStroke;
  }
}

class _CroppedImagePainter extends CustomPainter {
  final ui.Image image;
  final Rect? srcRect; // đơn vị pixel trên image

  _CroppedImagePainter({required this.image, required this.srcRect});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect src =
        srcRect ??
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final Rect dst = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..isAntiAlias = true;
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant _CroppedImagePainter oldDelegate) {
    return oldDelegate.image != image || oldDelegate.srcRect != srcRect;
  }
}

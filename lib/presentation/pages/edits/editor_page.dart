import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multitasking/app/assets/images.dart';
import 'package:multitasking/app/theme/app_colors.dart';
import 'package:multitasking/presentation/pages/edits/components/index.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  double _turns = 0.0; // 1.0 = 360 độ

  @override
  void initState() {
    super.initState();
  }

  void _handleRotate() {
    setState(() {
      // giữ hành vi cũ: +0.25 turns (90°)
      _turns = (_turns) % 4.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // hiển thị góc theo độ (0..1440 nếu _turns > 4), nhưng thường _turns trong [0,4)
    final degrees = (_turns * 360) % 360;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundDark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: SafeArea(
          child: Column(
            children: [
              const EditorHeader(),
              Expanded(
                child: Container(
                  color: AppColors.primary,
                  child: Center(
                    child: AnimatedRotation(
                      turns: _turns,
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset(ImagePath.appIcon),
                    ),
                  ),
                ),
              ),

              // Slider điều khiển góc
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Góc:',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Slider(
                            value: _turns,
                            min: 0.0,
                            max: 1, // 4 turns = 1440°, dùng modulo 4 bên trên
                            divisions: 4, // mỗi bước 0.25 turn = 90°
                            label: '${degrees.toStringAsFixed(0)}°',
                            onChanged: (v) {
                              setState(() {
                                _turns = v;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${degrees.toStringAsFixed(0)}°',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    // Optional: small quick buttons for +/- 45°
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              // -45° = -0.125 turns
                              _turns = (_turns - 0.125) % 4.0;
                              if (_turns < 0) _turns += 4.0;
                            });
                          },
                          icon: const Icon(Icons.rotate_left, color: Colors.white),
                          label: const Text('-45°', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 12),
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              // +45° = +0.125 turns
                              _turns = (_turns + 0.125) % 4.0;
                            });
                          },
                          icon: const Icon(Icons.rotate_right, color: Colors.white),
                          label: const Text('+45°', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom tools (vẫn dùng callback rotate)
              EditorBottom(
                rotate: () {
                  _handleRotate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

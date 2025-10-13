import 'package:logger/logger.dart';
import 'package:multitasking/app/log/logger_service.dart';

final logger = LoggerServiceImpl.logger;

class LoggerServiceImpl extends LoggerService {
  // Singleton pattern
  static final LoggerServiceImpl _instance = LoggerServiceImpl._internal();
  factory LoggerServiceImpl() => _instance;
  LoggerServiceImpl._internal();

  // Static getter để truy cập logger service
  static LoggerServiceImpl get logger => _instance;

  final Logger _logger = Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,

    ),
  );

  // Cache thông tin
  String? _cachedAppVersion;
  Map<String, dynamic>? _cachedDeviceInfo;

  @override
  void d(data, {stackTrace, arguments}) {
    _logger.d(data, stackTrace: stackTrace, error: arguments);
  }

  @override
  void e(Object error, {stackTrace, arguments}) {
    _logger.e(error, stackTrace: stackTrace, error: arguments);
  }

  @override
  void i(data, {stackTrace, arguments}) {
    _logger.i(data, stackTrace: stackTrace, error: arguments);
  }

  @override
  void logVideoError(Object error, {stackTrace, arguments}) {
    _logger.e('VIDEO ERROR: $error', stackTrace: stackTrace, error: arguments);
  }

  @override
  void w(data, {stackTrace, arguments}) {
    _logger.w(data, stackTrace: stackTrace, error: arguments);
  }

  ///
  /// Lấy thông tin version hiện tại (cached)
  ///
  Future<String> getAppVersion() async {
    if (_cachedAppVersion != null) return _cachedAppVersion!;

    try {
      // TODO: Implement package_info_plus để lấy version
      // final packageInfo = await PackageInfo.fromPlatform();
      // _cachedAppVersion = packageInfo.version;
      _cachedAppVersion = "1.0.0"; // Placeholder
      return _cachedAppVersion!;
    } catch (e) {
      _logger.e('Error getting app version: $e');
      return "Unknown";
    }
  }

  ///
  /// Lấy thông tin device (cached)
  ///
  Future<Map<String, dynamic>> getDeviceInfo() async {
    if (_cachedDeviceInfo != null) return _cachedDeviceInfo!;

    try {
      // TODO: Implement device_info_plus để lấy device info
      _cachedDeviceInfo = {
        'platform': 'Unknown',
        'model': 'Unknown',
        'version': 'Unknown',
      };
      return _cachedDeviceInfo!;
    } catch (e) {
      _logger.e('Error getting device info: $e');
      return {'error': e.toString()};
    }
  }
}

abstract class LoggerService {
  void d(dynamic data, {dynamic stackTrace, dynamic arguments});
  void i(dynamic data, {dynamic stackTrace, dynamic arguments});
  void w(dynamic data, {dynamic stackTrace, dynamic arguments});
  void e(Object error, {dynamic stackTrace, dynamic arguments});
  void logVideoError(Object error, {dynamic stackTrace, dynamic arguments});
}
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:multitasking/core/errors/failure.dart';
import 'package:multitasking/data/datasources/remote/fcm_service.dart';
import 'package:multitasking/domain/repositories/notification_repository.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  //
  final FcmService _fcmService;
  //

  NotificationRepositoryImpl(this._fcmService);

  @override
  Future<Either<Failure, String>> getFCMToken() async {
    try {
      final token = await _fcmService.getToken();
      return Right(token);
    } catch (e) {
      throw UnimplementedError();
    }
  }
}

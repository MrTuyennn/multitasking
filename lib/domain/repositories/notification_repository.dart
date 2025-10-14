import 'package:fpdart/fpdart.dart';
import 'package:multitasking/core/errors/failure.dart';

abstract class NotificationRepository {
  Future<Either<Failure, String>> getFCMToken();
}

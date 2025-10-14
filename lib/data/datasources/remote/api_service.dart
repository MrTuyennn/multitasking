import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:multitasking/data/models/request/login_request.dart';
import 'package:multitasking/data/models/response/base_response.dart';
import 'package:multitasking/data/models/response/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@lazySingleton
@RestApi()
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio, {@Named('baseUrl') String? baseUrl}) =
      _ApiService;

  @POST('/auth/login')
  Future<BaseResponse<LoginResponse>> login(@Body() LoginRequest request);
}

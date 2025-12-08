import 'package:bloc_2026/core/constants/endpoints.dart';
import 'package:bloc_2026/core/exceptions/http_exception.dart';
import 'package:bloc_2026/core/network/model/either.dart';
import 'package:bloc_2026/core/network/network_service.dart';
import 'package:bloc_2026/core/utils/error_logger.dart';
import 'package:bloc_2026/features/login/data/models/login_request.dart';
import 'package:bloc_2026/features/login/data/models/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<Either<AppException, LoginResponse>> login({
    required LoginRequest user,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final NetworkService networkService;

  LoginRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, LoginResponse>> login({
    required LoginRequest user,
  }) async {
    try {
      Either eitherType = await networkService.post(
        ApiEndpoint.login,
        data: user.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          LoginResponse user = LoginResponse.fromJson(response.data);

          networkService.updateHeader({'x-access-token': user.data!.token!});

          return Right(user);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(e, 'LoginRemoteDataSource.loginUser');
    }
  }
}

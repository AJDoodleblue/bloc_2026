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
          LoginResponse loginResponse = LoginResponse.fromJson(response.data);

          // Update header with Bearer token for authenticated requests
          networkService.updateHeader({
            'Authorization': 'Bearer ${loginResponse.accessToken}',
          });

          return Right(loginResponse);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(e, 'LoginRemoteDataSource.loginUser');
    }
  }
}

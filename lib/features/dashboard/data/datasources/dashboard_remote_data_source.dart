import 'package:bloc_2026/core/constants/endpoints.dart';
import 'package:bloc_2026/core/exceptions/http_exception.dart';
import 'package:bloc_2026/core/network/model/either.dart';
import 'package:bloc_2026/core/network/network_service.dart';
import 'package:bloc_2026/core/utils/error_logger.dart';
import 'package:bloc_2026/features/dashboard/data/models/products_response.dart';

abstract class DashboardRemoteDataSource {
  Future<Either<AppException, ProductsResponse>> getProducts({
    int limit = 10,
    int skip = 0,
  });
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final NetworkService networkService;

  DashboardRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<AppException, ProductsResponse>> getProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    try {
      Either eitherType = await networkService.get(
        ApiEndpoint.products,
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          ProductsResponse productsResponse =
              ProductsResponse.fromJson(response.data);
          return Right(productsResponse);
        },
      );
    } catch (e) {
      return ErrorLogger.handleException(
          e, 'DashboardRemoteDataSource.getProducts');
    }
  }
}

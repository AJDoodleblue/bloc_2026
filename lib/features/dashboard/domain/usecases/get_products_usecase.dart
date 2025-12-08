import 'package:bloc_2026/core/exceptions/http_exception.dart';
import 'package:bloc_2026/core/network/model/either.dart';
import 'package:bloc_2026/features/dashboard/data/models/products_response.dart';
import 'package:bloc_2026/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetProductsUseCase {
  final DashboardRepository _dashboardRepository;

  const GetProductsUseCase(this._dashboardRepository);

  Future<Either<AppException, ProductsResponse>> call({
    int limit = 10,
    int skip = 0,
  }) async {
    return _dashboardRepository.getProducts(limit: limit, skip: skip);
  }
}

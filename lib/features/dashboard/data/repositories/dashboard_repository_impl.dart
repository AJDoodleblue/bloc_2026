import 'package:bloc_2026/core/exceptions/http_exception.dart';
import 'package:bloc_2026/core/network/model/either.dart';
import 'package:bloc_2026/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:bloc_2026/features/dashboard/data/models/products_response.dart';
import 'package:bloc_2026/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardRemoteDataSource _dashboardDataSource;

  DashboardRepositoryImpl(this._dashboardDataSource);

  @override
  Future<Either<AppException, ProductsResponse>> getProducts({
    int limit = 10,
    int skip = 0,
  }) {
    return _dashboardDataSource.getProducts(limit: limit, skip: skip);
  }
}

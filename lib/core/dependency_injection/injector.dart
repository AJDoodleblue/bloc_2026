import 'package:bloc_2026/core/database/hive_storage_service.dart';
import 'package:bloc_2026/core/network/dio_network_service.dart';
import 'package:bloc_2026/core/network/network_service.dart';
import 'package:bloc_2026/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:bloc_2026/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bloc_2026/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:bloc_2026/features/dashboard/domain/usecases/get_products_usecase.dart';
import 'package:bloc_2026/features/login/data/datasources/login_remote_data_source.dart';
import 'package:bloc_2026/features/login/data/repositories/login_repository_impl.dart';
import 'package:bloc_2026/features/login/domain/repositories/login_repository.dart';
import 'package:bloc_2026/features/login/domain/usecases/login_usecase.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> init() async {
  injector
    ///Service's
    ..registerLazySingleton<NetworkService>(DioNetworkService.new)
    ..registerLazySingleton<DioNetworkService>(DioNetworkService.new)
    ..registerLazySingleton<HiveService>(HiveService.new)

    /// DataSources
    ..registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(injector()),
    )
    ..registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(injector()),
    )

    ///Repositories
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(injector()),
    )
    ..registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(injector()),
    )

    ///UseCases
    ..registerLazySingleton<LoginUseCases>(() => LoginUseCases(injector()))
    ..registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(injector()),
    );
}

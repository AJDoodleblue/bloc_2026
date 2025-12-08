import 'package:bloc_2026/core/constants/routes.dart';
import 'package:bloc_2026/core/database/hive_storage_service.dart';
import 'package:bloc_2026/core/network/network_service.dart';
import 'package:bloc_2026/core/utils/configuration.dart';
import 'package:bloc_2026/routes/app_routes.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LogoutService {
  LogoutService._internal({
    required this.hiveService,
    required this.networkService,
    required this.userPreferences,
  });

  static final LogoutService _instance = LogoutService._internal(
    hiveService: GetIt.instance<HiveService>(),
    networkService: GetIt.instance<NetworkService>(),
    userPreferences: UserPreferences.instance,
  );

  static LogoutService get instance => _instance;

  final HiveService hiveService;
  final NetworkService? networkService;
  final UserPreferences userPreferences;

  Future<void> logoutAndNavigate() async {
    await clearData();
  }

  Future<void> clearData() async {
    final hive = hiveService;
    await hive.clear();
    userPreferences.clearPreferences();
    networkService?.updateHeader({'Authorization': ''});
    navigatorKey.currentContext?.go(RoutesName.loginPath);
  }
}

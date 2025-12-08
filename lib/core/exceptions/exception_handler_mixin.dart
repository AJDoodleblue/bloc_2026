import 'dart:async';
import 'dart:developer';

import 'dart:io';
import 'package:bloc_2026/core/constants/routes.dart';
import 'package:bloc_2026/core/database/hive_storage_service.dart';
import 'package:bloc_2026/core/exceptions/http_exception.dart';
import 'package:bloc_2026/core/network/connection/connection_listener.dart';
import 'package:bloc_2026/core/network/model/either.dart';
import 'package:bloc_2026/core/network/model/response.dart' as response;
import 'package:bloc_2026/core/network/network_service.dart';
import 'package:bloc_2026/core/utils/configuration.dart';
import 'package:bloc_2026/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

mixin ExceptionHandlerMixin on NetworkService {
  final HiveService _hiveService = GetIt.instance<HiveService>();
  UserPreferences? userPreferences;
  NetworkService? networkService;

  Future<Either<AppException, response.Response>>
  handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    var connectionStatus = ConnectionStatusListener.getInstance();

    // Check for internet connection
    if (await connectionStatus.checkConnection()) {
      try {
        Response<dynamic> res = await handler();
        return Right(
          response.Response(
            statusCode: res.statusCode ?? 200,
            data: res.data,
            statusMessage: res.statusMessage,
          ),
        );
      } catch (e) {
        String message = '';
        String identifier = '';
        int statusCode = 0;

        if (e is DioException) {
          if (e.response?.statusCode == 401) {
            log("Unauthorized - Triggering logout...${e.response?.statusCode}");
            logout();

            return Left(
              AppException(
                message: "SESSION_EXPIRY_MSG".tr,
                statusCode: 401,
                identifier: 'Unauthorized at $endpoint',
              ),
            );
          }

          // Extract error message from response body
          final responseData = e.response?.data;
          if (responseData is Map<String, dynamic> &&
              responseData.containsKey('message')) {
            message = responseData['message'];
          } else {
            message = e.message ?? 'An error occurred';
          }
          statusCode = e.response?.statusCode ?? 0;
          identifier = 'DioException ${e.message} \nat $endpoint';
        } else if (e is SocketException) {
          message = 'Unable to connect to the server.';
          statusCode = 0;
          identifier = 'Socket Exception ${e.message}\n at $endpoint';
        } else {
          message = 'Unknown error occurred';
          statusCode = 0;
          identifier = 'Unknown error ${e.toString()}\n at $endpoint';
        }

        return Left(
          AppException(
            message: message,
            statusCode: statusCode,
            identifier: identifier,
          ),
        );
      }
    } else {
      log("No internet");
      return Left(
        AppException(
          message: "NO_INTERNET_MSG".tr,
          statusCode: 0,
          identifier: 'No Internet at $endpoint',
        ),
      );
    }
  }

  void logout() async {
    await _hiveService.clear();
    userPreferences?.clearPreferences();
    networkService?.updateHeader({'Authorization': ''});
    nav();
  }

  void nav() {
    navigatorKey.currentState?.context.go(RoutesName.loginPath);
  }
}

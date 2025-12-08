import 'package:bloc_2026/core/constants/constant.dart';
import 'package:bloc_2026/core/database/hive_storage_service.dart';
import 'package:bloc_2026/core/network/model/either.dart';
import 'package:bloc_2026/core/network/network_service.dart';
import 'package:bloc_2026/core/utils/configuration.dart';
import 'package:bloc_2026/core/utils/error_logger.dart';
import 'package:bloc_2026/features/login/data/models/login_request.dart';
import 'package:bloc_2026/features/login/data/models/login_response.dart';
import 'package:bloc_2026/features/login/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_it/get_it.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCases _loginUseCases;
  final HiveService _hiveService;
  final NetworkService _networkService;

  LoginCubit(this._loginUseCases)
    : _hiveService = GetIt.instance<HiveService>(),
      _networkService = GetIt.instance<NetworkService>(),
      super(const LoginLoaded());

  void validate(String email, String password, String deviceToken) {
    final currentState = state;
    if (currentState is LoginLoaded) {
      String emailError = '';
      String passwordError = '';

      if (email.isEmpty) {
        emailError = "EMAIL_VALIDATION_TEXT".tr;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        emailError = "ENTER_VALID_EMAIL".tr;
      }

      if (password.isEmpty) {
        passwordError = "PASSWORD_VALIDATION_TEXT".tr;
      }

      if (emailError.isNotEmpty || passwordError.isNotEmpty) {
        emit(
          currentState.copyWith(
            emailError: emailError,
            passwordError: passwordError,
          ),
        );
      } else {
        LoginRequest request = LoginRequest(
          identifier: email,
          password: password,
          deviceToken: deviceToken,
        );
        login(request);
      }
    }
  }

  Future<void> login(LoginRequest user) async {
    final currentState = state as LoginLoaded;
    emit(currentState.copyWith(isLoading: true));
    Either result = await _loginUseCases.login(user: user);
    result.fold(
      (error) {
        ErrorLogger.log('LoginCubit.login', error.identifier);
        emit(
          currentState.copyWith(
            errorMessage: error.message,
            isLoading: false,
            isError: true,
          ),
        );
      },
      (user) {
        if (user.data != null) {
          LoginResponse response = user as LoginResponse;
          UserPreferences userPreferences = UserPreferences.instance;
          userPreferences.setUser(user.data!);
          String token = response.data!.token ?? '';
          _hiveService.set(userToken, token);
          _hiveService.setUser(response.data!);
          // if (response.data?.faceId != null ||
              // response.data?.fingerPrintId != null) {
            // _hiveService.set(localAuth, enable);
            // if (response.data?.faceId != null) {
            //   _hiveService.set(faceIdAuth, enable);
            // } else if (response.data?.fingerPrintId != null) {
            //   _hiveService.set(fingerPrintAuth, enable);
            // }
          // }
          _networkService.updateHeader({'x-access-token': token});
          emit(LoginSuccess(user));
        } else {
          emit(
            currentState.copyWith(
              errorMessage: 'Internal Error occurred',
              isLoading: false,
              isError: true,
            ),
          );
        }
      },
    );
  }

  void validateEmail(String value) {
    String error = '';
    final currentState = state;
    if (value.isEmpty) {
      error = "EMAIL_VALIDATION_TEXT".tr;
    }
    // else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    //   error = "ENTER_VALID_EMAIL".tr;
    // }
    if (currentState is LoginLoaded) {
      emit(currentState.copyWith(emailError: error));
    }
  }

  void validatePassword(String value) {
    String error = '';
    final currentState = state;
    if (value.isEmpty) {
      error = "PASSWORD_VALIDATION_TEXT".tr;
    }
    if (currentState is LoginLoaded) {
      emit(currentState.copyWith(passwordError: error));
    }
  }

  void resetError() {
    final currentState = state as LoginLoaded;
    emit(currentState.copyWith(isLoading: false, isError: false));
  }
}

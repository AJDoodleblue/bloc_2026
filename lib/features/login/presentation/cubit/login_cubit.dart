import 'package:bloc_2026/core/constants/constant.dart';
import 'package:bloc_2026/core/database/hive_storage_service.dart';
import 'package:bloc_2026/core/network/model/either.dart';
import 'package:bloc_2026/core/network/network_service.dart';
import 'package:bloc_2026/core/utils/configuration.dart';
import 'package:bloc_2026/core/utils/error_logger.dart';
import 'package:bloc_2026/features/login/data/models/login_request.dart';
import 'package:bloc_2026/features/login/data/models/login_response.dart';
import 'package:bloc_2026/features/login/domain/usecases/login_usecase.dart';
import 'package:bloc_2026/shared/models/user_data.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_it/get_it.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCases _loginUseCases;
  final HiveService _hiveService;
  final NetworkService _networkService;

  LoginCubit(this._loginUseCases)
      : _hiveService = GetIt.instance<HiveService>(),
        _networkService = GetIt.instance<NetworkService>(),
        super(const LoginState());

  void validate(String username, String password) {
    String usernameError = '';
    String passwordError = '';

    if (username.isEmpty) {
      usernameError = "USERNAME_VALIDATION_TEXT".tr;
    }

    if (password.isEmpty) {
      passwordError = "PASSWORD_VALIDATION_TEXT".tr;
    }

    if (usernameError.isNotEmpty || passwordError.isNotEmpty) {
      emit(state.copyWith(
        usernameError: usernameError,
        passwordError: passwordError,
      ));
    } else {
      LoginRequest request = LoginRequest(
        username: username,
        password: password,
        expiresInMins: tokenExpiryMins,
      );
      login(request);
    }
  }

  Future<void> login(LoginRequest user) async {
    emit(state.copyWith(isLoading: true));

    Either result = await _loginUseCases.login(user: user);

    result.fold(
      (error) {
        ErrorLogger.log('LoginCubit.login', error.identifier);
        emit(state.copyWith(
          message: error.message,
          isLoading: false,
          isFailure: true,
          isSuccess: false,
        ));
      },
      (loginResponse) {
        LoginResponse response = loginResponse as LoginResponse;

        // Create UserData from LoginResponse
        UserData userData = UserData(
          id: response.id,
          username: response.username,
          email: response.email,
          firstName: response.firstName,
          lastName: response.lastName,
          gender: response.gender,
          image: response.image,
          accessToken: response.accessToken,
          refreshToken: response.refreshToken,
        );

        UserPreferences userPreferences = UserPreferences.instance;
        userPreferences.setUser(userData);

        String token = response.accessToken ?? '';
        _hiveService.set(userToken, token);
        _hiveService.setUser(userData);

        _networkService.updateHeader({'Authorization': 'Bearer $token'});

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          loginData: response,
        ));
      },
    );
  }

  void validateUsername(String value) {
    String error = '';
    if (value.isEmpty) {
      error = "USERNAME_VALIDATION_TEXT".tr;
    }
    emit(state.copyWith(usernameError: error));
  }

  void validatePassword(String value) {
    String error = '';
    if (value.isEmpty) {
      error = "PASSWORD_VALIDATION_TEXT".tr;
    }
    emit(state.copyWith(passwordError: error));
  }

  void clearState() {
    emit(state.copyWith(
      message: '',
      isFailure: false,
      isLoading: false,
      isSuccess: false,
    ));
  }

  void resetError() {
    emit(state.copyWith(
      isFailure: false,
      message: '',
    ));
  }
}

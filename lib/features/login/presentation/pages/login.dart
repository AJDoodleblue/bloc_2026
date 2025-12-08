import 'dart:developer';

import 'package:bloc_2026/core/constants/asset_path.dart';
import 'package:bloc_2026/core/constants/routes.dart';
import 'package:bloc_2026/core/dependency_injection/injector.dart';
import 'package:bloc_2026/core/extension/roles.dart';
import 'package:bloc_2026/core/utils/configuration.dart';
import 'package:bloc_2026/features/login/domain/usecases/login_usecase.dart';
import 'package:bloc_2026/features/login/presentation/cubit/login_cubit.dart';
import 'package:bloc_2026/features/login/presentation/cubit/login_state.dart';
import 'package:bloc_2026/shared/theme/app_colors.dart';
import 'package:bloc_2026/shared/theme/text_styles.dart';
import 'package:bloc_2026/shared/widgets/custom_text_input.dart';
import 'package:bloc_2026/shared/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginCubit _loginCubit;

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCubit();
  }

  void _initializeCubit() {
    final loginUseCases = injector<LoginUseCases>();
    _loginCubit = LoginCubit(loginUseCases);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: Scaffold(
        backgroundColor: AppColors.appBackGround,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (BuildContext context, LoginState state) {
                  if (state.isSuccess && state.loginData != null) {
                    UserPreferences.instance.setUserRole(UserRole.customer);
                    context.go(RoutesName.homePage);
                  } else if (state.isFailure && state.message.isNotEmpty) {
                    _showErrorSnackBar(context, state.message);
                    _loginCubit.resetError();
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.colorPrimary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.lock_outline_rounded,
                            size: 40,
                            color: AppColors.colorPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Text(
                          "Welcome Back!",
                          style: AppTextStyles.openSansBold24.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          "Sign in to continue",
                          style: AppTextStyles.openSansRegular16.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      CustomTextInput(
                        textEditingController: usernameTextController,
                        hintText: "Enter your username",
                        title: "USERNAME".tr,
                        svgIconPath: AssetPath.emailIcon,
                        inputType: TextInputType.text,
                        onChange: (value) {
                          context.read<LoginCubit>().validateUsername(value);
                        },
                      ),
                      if (state.usernameError.isNotEmpty)
                        _buildFieldValidation(state.usernameError),
                      const SizedBox(height: 8),
                      CustomTextInput(
                        textEditingController: passwordTextController,
                        hintText: "Enter your password",
                        title: "PASSWORD".tr,
                        svgIconPath: AssetPath.eyeOpenIcon,
                        isPassword: true,
                        onChange: (value) {
                          context.read<LoginCubit>().validatePassword(value);
                        },
                      ),
                      if (state.passwordError.isNotEmpty)
                        _buildFieldValidation(state.passwordError),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  context.read<LoginCubit>().validate(
                                    usernameTextController.text.trim(),
                                    passwordTextController.text,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.colorPrimary,
                            foregroundColor: AppColors.colorWhite,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.colorWhite,
                                  ),
                                )
                              : Text(
                                  "LOGIN".tr,
                                  style: AppTextStyles.openSansBold16.copyWith(
                                    color: AppColors.colorWhite,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.colorSecondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.colorSecondary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: AppColors.colorSecondary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Test Credentials",
                                  style: AppTextStyles.openSansBold14.copyWith(
                                    color: AppColors.colorSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Username: emilys\nPassword: emilyspass",
                              style: AppTextStyles.openSansRegular14.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldValidation(String errorValue) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          const Icon(Icons.error_outline, size: 14, color: AppColors.colorRed),
          const SizedBox(width: 4),
          Text(
            errorValue,
            style: AppTextStyles.openSansRegular12.copyWith(
              color: AppColors.colorRed,
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    CustomToast.showErrorToast(context, message);
    log("ERROR ----- $message");
  }
}

import 'dart:developer';

import 'package:bloc_2026/core/constants/constant.dart';
import 'package:bloc_2026/core/constants/routes.dart';
import 'package:bloc_2026/core/dependency_injection/injector.dart';
import 'package:bloc_2026/core/extension/roles.dart';
import 'package:bloc_2026/core/utils/configuration.dart';
import 'package:bloc_2026/features/login/domain/usecases/login_usecase.dart';
import 'package:bloc_2026/features/login/presentation/cubit/login_cubit.dart';
import 'package:bloc_2026/shared/config/dimens.dart';
import 'package:bloc_2026/shared/theme/app_colors.dart';
import 'package:bloc_2026/shared/widgets/custom_loader.dart';
import 'package:bloc_2026/shared/widgets/custom_text_input.dart';
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

  final mobileTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCubit();
  }

  void _initializeCubit() async {
    final loginUseCases = injector<LoginUseCases>();
    _loginCubit = LoginCubit(loginUseCases);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: Scaffold(
        backgroundColor: AppColors.appBackGround,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.standard_40),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (BuildContext context, LoginState state) {
                if (state is LoginSuccess) {
                  UserPreferences.instance.setUserRole(UserRole.customer);

                  context.go(RoutesName.homePage);
                } else if (state is LoginLoaded) {
                  if (state.isError) {
                    _showErrorSnackBar(context, state.errorMessage);
                    _loginCubit.resetError();
                  }
                }
              },
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return const Center(child: CustomLoader());
                } else if (state is LoginLoaded) {
                  return Column(
                    children: <Widget>[
                      const SizedBox(height: Dimens.standard_140),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN".tr,
                            style: TextStyle(
                              fontSize: Dimens.standard_36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: Dimens.standard_20),
                        ],
                      ),
                      const SizedBox(height: Dimens.standard_60),
                      CustomTextInput(
                        textEditingController: mobileTextController,
                        hintText: "EMAIL".tr,
                        title: "EMAIL".tr,
                        svgIconPath: splashIcon,
                        inputType: TextInputType.emailAddress,
                        onChange: (value) {
                          context.read<LoginCubit>().validateEmail(value);
                        },
                      ),
                      if (state.emailError.isNotEmpty)
                        buildFieldValidation(state.emailError),
                      CustomTextInput(
                        textEditingController: passwordTextController,
                        hintText: "PASSWORD".tr,
                        title: "PASSWORD".tr,
                        svgIconPath: splashIcon,
                        isPassword: true,
                        onChange: (value) {
                          context.read<LoginCubit>().validatePassword(value);
                        },
                      ),
                      if (state.passwordError.isNotEmpty)
                        buildFieldValidation(state.passwordError),
                      const SizedBox(height: Dimens.standard_10),
                      const SizedBox(height: Dimens.standard_20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginCubit>().validate(
                            mobileTextController.text.trim(),
                            passwordTextController.text,
                            '',
                          );
                        },
                        child: Text("LOGIN".tr.toUpperCase()),
                      ),
                      const SizedBox(height: Dimens.standard_50),
                      ElevatedButton(
                        onPressed: () {
                          context.push(RoutesName.signUp);
                        },
                        child: Text("SIGN_UP".tr.toUpperCase()),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Align buildFieldValidation(String errorValue) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        errorValue,
        style: const TextStyle(
          color: AppColors.colorRed,
          fontSize: Dimens.standard_12,
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    // CustomToast.showErrorToast(context, message);
    log("ERROR ----- $message");
  }
}

import 'package:bloc_2026/shared/theme/app_colors.dart';
import 'package:bloc_2026/shared/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:toastification/toastification.dart';


class CustomToast {
  static void showErrorToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text("ERROR".tr, style: AppTextStyles.openSansBold14),
      description: Text(message, style: AppTextStyles.openSansRegular12),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
    );
  }

  static void showSuccessToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text("SUCCESS".tr, style: AppTextStyles.openSansBold14),
      description: Text(message, style: AppTextStyles.openSansRegular12),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
    );
  }

  static void showInfoToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text("INFO".tr, style: AppTextStyles.openSansBold14),
      description: Text(message, style: AppTextStyles.openSansRegular12),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      primaryColor: AppColors.colorPrimary,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
    );
  }

  static void showWarningToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text("WARNING".tr, style: AppTextStyles.openSansBold14),
      description: Text(message, style: AppTextStyles.openSansRegular12),
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.warning,
      style: ToastificationStyle.minimal,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
    );
  }
}

import 'package:bloc_2026/core/constants/asset_path.dart';
import 'package:bloc_2026/shared/config/dimens.dart';
import 'package:bloc_2026/shared/theme/app_colors.dart';
import 'package:bloc_2026/shared/theme/text_styles.dart';
import 'package:bloc_2026/shared/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatefulWidget {
  final String hintText;
  final String? svgIconPath;
  final String title;
  final bool isPassword;
  final bool isRequired;
  final String errorMessage;
  final bool isEnabled;
  final TextEditingController textEditingController;
  final Function(String value)? onChange;
  final TextInputType? inputType;
  final int? maxLength;
  final bool? disableNumber;
  final String tooltip;

  const CustomTextInput({
    super.key,
    required this.hintText,
    this.svgIconPath,
    required this.title,
    this.isPassword = false,
    this.errorMessage = '',
    required this.textEditingController,
    this.onChange,
    this.inputType,
    this.maxLength,
    this.isEnabled = true,
    this.isRequired = false,
    this.disableNumber = false,
    this.tooltip = '',
  });

  @override
  CustomTextInputState createState() => CustomTextInputState();
}

class CustomTextInputState extends State<CustomTextInput> {
  bool _hasText = false;
  bool _isObscured = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _hasText = widget.textEditingController.text.isNotEmpty;
    widget.textEditingController.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    if (mounted) {
      setState(() {
        _hasText = widget.textEditingController.text.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_handleTextChange);
    super.dispose();
  }

  void setError(String? errorMessage) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _errorMessage = errorMessage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimens.standard_5,
        bottom: Dimens.standard_5,
        // left: Dimens.standard_30,
        // right: Dimens.standard_30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (_hasText) ...[
          Row(
            children: [
              Text(
                widget.title,
                style: AppTextStyles.openSansRegular14w400.copyWith(
                  color: AppColors.colorBlack,
                ),
              ),
              const SizedBox(width: Dimens.standard_5),
              widget.isRequired
                  ? Text(
                      '*',
                      style: AppTextStyles.openSansRegular14w400.copyWith(
                        color: AppColors.colorRed,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          // ],
          const SizedBox(height: Dimens.standard_10),
          Material(
            elevation: Dimens.standard_1,
            borderRadius: BorderRadius.circular(Dimens.standard_20),
            child: TextFormField(
              onTapOutside: (value) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              enabled: widget.isEnabled,
              keyboardType: widget.inputType,
              inputFormatters: [
                if (widget.disableNumber == true)
                  FilteringTextInputFormatter.deny(RegExp(r'\d')),
                if (widget.maxLength != null)
                  LengthLimitingTextInputFormatter(widget.maxLength),
              ],
              controller: widget.textEditingController,
              obscureText: widget.isPassword && _isObscured,
              // Use _isObscured
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: _errorMessage != null
                      ? AppColors.colorRed
                      : AppColors.color858485,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: AppColors.colorWhite,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: Dimens.standard_16,
                  horizontal: Dimens.standard_16,
                ),
                suffixIcon: widget.svgIconPath != null
                    ? GestureDetector(
                        onTap: widget.isPassword
                            ? () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.standard_12),
                          child: getSvg(
                            widget.isPassword
                                ? _isObscured
                                      ? AssetPath.eyeClosedIcon
                                      : widget.svgIconPath!
                                : widget.svgIconPath!,
                            color: _hasText
                                ? AppColors.color858485
                                : AppColors.colorD9D9D9,
                          ),
                        ),
                      )
                    : null,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_24),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_24),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_24),
                  borderSide: const BorderSide(color: AppColors.colorRed),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_24),
                  borderSide: const BorderSide(color: AppColors.colorRed),
                ),
              ),
              style: TextStyle(
                color: widget.isEnabled
                    ? AppColors.colorBlack
                    : AppColors.greyText,
                fontSize: Dimens.standard_14,
                fontWeight: FontWeight.w700,
              ),
              onChanged: widget.onChange,
            ),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: Dimens.standard_4),
              child: Text(
                _errorMessage ?? '',
                style: const TextStyle(
                  color: AppColors.colorRed,
                  fontSize: Dimens.standard_12,
                ),
              ),
            ),
          if (widget.errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: Dimens.standard_4),
              child: Text(
                widget.errorMessage,
                style: const TextStyle(
                  color: AppColors.colorRed,
                  fontSize: Dimens.standard_12,
                ),
              ),
            ),
          const SizedBox(height: Dimens.standard_4),
        ],
      ),
    );
  }
}

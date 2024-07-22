import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final double borderRadius;
  final TextStyle? hintStyle;
  final String? hintText;
  final TextStyle? labelStyle;
  final String? labelText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final double? horizontalPadding;
  final TextInputAction? textInputAction;

  final String? Function(String? val)? validator;
  final Function(String s)? onChanged;
  final Function(String?)? onFieldSubmitted;

  final Function()? onTap;

  final bool hasTitle;
  final bool isTitleBold;
  final String title;

  final int numberOfLines;
  final bool? readOnly;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.borderRadius = 8,
    this.horizontalPadding,
    this.textInputType,
    this.textInputAction,
    this.hintStyle,
    this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
    this.hasTitle = true,
    this.title = "",
    this.numberOfLines = 1,
    this.readOnly = false,
    this.isTitleBold = false,
    this.onTap,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.labelStyle,
    this.labelText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 15),
      child: Column(
        children: [
          TextFormField(
            readOnly: readOnly ?? false,
            controller: controller,
            maxLines: numberOfLines,
            keyboardType: textInputType ?? TextInputType.text,
            textInputAction: textInputAction ?? TextInputAction.next,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              focusedBorder: focusedBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 221, 221, 221),
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
              enabledBorder: enabledBorder ??
                  OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 221, 221, 221),
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              labelText: labelText,
              // labelStyle: labelStyle ??
              //     AppTextStyles.p2Style.copyWith(color: AppColors.n300Color),
              // hintStyle: hintStyle ??
              //     AppTextStyles.p2Style.copyWith(color: AppColors.n200Color),
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              fillColor: backgroundColor ?? Colors.white,
              filled: true,
              alignLabelWithHint: true,
            ),
            obscureText: isObscureText ?? false,
            // style: AppTextStyles.p1Style,
            cursorColor: Colors.blue,
            textAlignVertical: TextAlignVertical.top,
            onTap: onTap,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

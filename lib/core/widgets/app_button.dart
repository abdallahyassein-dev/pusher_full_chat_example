import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? width;
  final double? height;
  final String buttonText;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final double? fontSize;

  const AppButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.height,
    this.width,
    required this.buttonText,
    this.textStyle,
    this.fontSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor ?? const Color(0xff168AFF),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 32,
            vertical: verticalPadding ?? 14,
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          Size(width ?? 300, height ?? 70),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return backgroundColor ??
                  const Color(
                      0xff168AFF); // Change to desired splash color or keep transparent
            }
            return null; // Use default overlay color
          },
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: textStyle ??
            TextStyle(
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.bold,
                color: Colors.white),
      ),
    );
  }
}

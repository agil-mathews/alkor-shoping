// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:alkor_shopin/core/themes/color_scheme.dart';
import 'package:alkor_shopin/core/utils/mediaquery.dart';

Widget customTextButton({
  required BuildContext context,
  required String label,
  required VoidCallback onPressed,
  Color? textColor,
  double borderRadius = 20.0,
  Color? borderColor,
  Color? backgroundColor = Colors.white,
  final double? defaultFontSize = 14,
}) {
  return TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(backgroundColor),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      side: WidgetStatePropertyAll(
        BorderSide(
          color: borderColor ?? AppColors.black, 
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
    ),
    child: Text(
      label,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: textColor, 
        fontSize: getResponsiveFontSize(
          context,
          defaultFontSize: defaultFontSize!,
          widePortraitFontSize: 10,
          landscapeWideFontSize: 7,
        ),
      ),
    ),
  );
}

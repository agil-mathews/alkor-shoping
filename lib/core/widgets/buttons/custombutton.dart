import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:alkor_shopin/core/themes/color_scheme.dart';
import 'package:alkor_shopin/core/utils/mediaquery.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool? isLoading;
  final Color color;
  final Color textColor;
  final double defaultFontSize;
  final double widePortraitFontSize;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEnabled,
    required this.color,
    required this.textColor,
    required this.defaultFontSize,
    required this.widePortraitFontSize,
    required this.borderRadius,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: isEnabled ? color : Colors.grey,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 32.0),
      ),
      child:
          isLoading == true
              ? const SpinKitThreeBounce(color: AppColors.white, size: 10.0)
              : Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textColor,
                  fontSize: getResponsiveFontSize(
                    context,
                    defaultFontSize: defaultFontSize,
                    widePortraitFontSize: widePortraitFontSize,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
    );
  }
}

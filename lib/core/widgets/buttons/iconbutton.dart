import 'package:flutter/material.dart';
import 'package:alkor_shopin/core/utils/mediaquery.dart';

class ButtonwithIcon extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Widget? svgIcon;
  final bool iconOnLeft;
  final Color? fillColor;
  final Color textColor;
  final double? borderRadius;
  final Color iconColor;
  final Color? borderColor;
  final bool showBorder;
  final double? defaultFontSize;
  final double? widePortraitFontSize;

  const ButtonwithIcon({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.iconOnLeft = false,
    this.fillColor,
    this.borderRadius,
    required this.textColor,
    required this.iconColor,
    this.showBorder = true,
    this.borderColor,
    this.defaultFontSize,
    this.widePortraitFontSize,
    this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      label,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: textColor,
        fontSize: getResponsiveFontSize(
          context,
          defaultFontSize: defaultFontSize ?? 16,
          widePortraitFontSize: widePortraitFontSize ?? 8,
          landscapeWideFontSize: 7,
        ),
        fontWeight: FontWeight.bold,
      ),
    );

    final iconWidget =
        icon != null
            ? Icon(icon, size: 20, color: iconColor)
            : svgIcon != null
            ? SizedBox(height: 20, width: 20, child: svgIcon)
            : null;

    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
        backgroundColor:
            fillColor != null ? WidgetStatePropertyAll(fillColor) : null,
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        side:
            showBorder
                ? WidgetStatePropertyAll(
                  BorderSide(
                    color: borderColor ?? Color.fromARGB(255, 216, 216, 216),
                  ),
                )
                : null,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconWidget != null && iconOnLeft) ...[
            iconWidget,
            const SizedBox(width: 6),
          ],
          textWidget,
          if (iconWidget != null && !iconOnLeft) ...[
            const SizedBox(width: 4),
            iconWidget,
          ],
        ],
      ),
    );
  }
}

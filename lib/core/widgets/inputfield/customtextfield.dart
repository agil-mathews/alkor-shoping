
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alkor_shopin/core/themes/color_scheme.dart';
import 'package:alkor_shopin/core/utils/mediaquery.dart';


class CustomEditTextField extends StatefulWidget {
  final String? labelText;
  final String? prefix;
  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextStyle? labelStyle;
  final bool? obscureText;
  final bool? showToggleIcon;
  final TextInputType? keyBoardType;
  final int? maxlines;
  final bool isRequired;
  final List<TextInputFormatter>? inputformatters;
  final Function(String)? onTextChanged;

  const CustomEditTextField({
    super.key,
    this.labelText,
    this.controller,
    required this.hintText,
    this.validator,
    this.labelStyle,
    this.obscureText = false,
    this.showToggleIcon = false,
    this.keyBoardType,
    this.maxlines = 1,
    this.inputformatters,
    this.onTextChanged,
    this.prefix,
    this.isRequired = true,
  });

  @override
  CustomEditTextFieldState createState() => CustomEditTextFieldState();
}

class CustomEditTextFieldState extends State<CustomEditTextField> {
  late TextEditingController _controller;
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isObscured = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isPassword =
        widget.obscureText ?? false || (widget.showToggleIcon ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.labelText ?? '',
            style:
                widget.labelStyle ??
                Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: getResponsiveFontSize(
                    context,
                    defaultFontSize: 16,
                    widePortraitFontSize: 8,
                    landscapeWideFontSize: 7,
                  ),
                ),
            children:
                widget.isRequired
                    ? [
                      TextSpan(
                        text: ' *',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ]
                    : [],
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          selectionHeightStyle: BoxHeightStyle.max,
          controller: _controller,
          keyboardType: widget.keyBoardType,
          inputFormatters: widget.inputformatters,
          onChanged: widget.onTextChanged,
          maxLines: widget.maxlines,
          obscureText: isPassword ? _isObscured : false,
          validator: widget.validator,
          autofillHints: [AutofillHints.email],
          decoration: InputDecoration(
            isDense: true,
            errorMaxLines: 4,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixText: widget.prefix,
            prefixStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: getResponsiveFontSize(
                context,
                defaultFontSize: 16,
                widePortraitFontSize: 10,
              ),
              fontWeight: FontWeight.bold,
            ),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey,
              letterSpacing: -0.5,
              fontSize: getResponsiveFontSize(
                context,
                defaultFontSize: 16,
                widePortraitFontSize: 8,
                landscapeWideFontSize: 7,
              ),
            ),
            errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.error,
              letterSpacing: -0.5,
              fontSize: getResponsiveFontSize(
                context,
                defaultFontSize: 15,
                widePortraitFontSize: 8,
                landscapeWideFontSize: 7,
              ),
            ),
            suffixIcon:
                (widget.showToggleIcon ?? false)
                    ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                    : null,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

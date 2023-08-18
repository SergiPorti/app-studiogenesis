import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final TextInputType? textInputType;
  final String? label;
  final TextStyle? labelStyle;
  final double? inputHeight;
  final String? placeHolder;
  final String? errorText;
  final String? counterText;
  final TextStyle? counterStyle;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool obscureText;
  final Color? inputBackgroundColor;
  final Color? inputBorderColor;
  final bool readOnly;
  final TextEditingController? controller;
  final Function(String)? onChangedText;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final bool clearAfterSubmit;
  final Function? onTap;
  final bool expands;
  const InputText({
    super.key,
    this.textInputType,
    this.inputHeight,
    this.placeHolder,
    this.errorText,
    this.counterText,
    this.counterStyle,
    this.enabled = true,
    this.prefixIcon,
    this.sufixIcon,
    this.readOnly = false,
    this.controller,
    this.onChangedText,
    this.initialValue,
    this.inputBackgroundColor,
    this.textInputAction,
    this.label,
    this.labelStyle,
    this.onFieldSubmitted,
    this.clearAfterSubmit = false,
    this.onTap,
    this.expands = false,
    this.inputBorderColor,
    this.obscureText = false,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!,
              style: widget.labelStyle ??
                  TextStyle(
                      fontSize: AppDimensions.main,
                      fontWeight: FontWeight.w600)),
          SizedBox(height: AppDimensions.small)
        ],
        TextFormField(
          obscureText: widget.obscureText,
          style: TextStyle(
              color: widget.inputBackgroundColor != null
                  ? Colors.white
                  : AppColors.generalBackground,
              fontSize: AppDimensions.main,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none),
          expands: widget.expands,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            constraints: BoxConstraints(minHeight: widget.inputHeight ?? 44),
            contentPadding: EdgeInsets.all(AppDimensions.xmain),
            hintText: widget.placeHolder,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: AppDimensions.main,
                fontWeight: FontWeight.w500),
            errorText: widget.errorText,
            errorStyle: TextStyle(
                color: Colors.red,
                fontSize: AppDimensions.label,
                fontWeight: FontWeight.w400),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(AppDimensions.xmain)),
            counterText: widget.counterText,
            counterStyle: widget.counterStyle,
            fillColor: widget.enabled
                ? widget.inputBackgroundColor ?? Colors.white
                : AppColors.secondaryDisabledButton,
            filled: true,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.xmain),
              ),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.sufixIcon,
          ),
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onChanged: (query) => widget.onChangedText?.call(query),
          controller: widget.controller,
          initialValue: widget.initialValue,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted != null
              ? (value) {
                  widget.onFieldSubmitted?.call(value);
                  if (widget.clearAfterSubmit) {
                    widget.controller?.clear();
                  }
                }
              : null,
          onTap: widget.onTap != null
              ? () {
                  widget.onTap?.call();
                }
              : null,
        ),
      ],
    );
  }
}

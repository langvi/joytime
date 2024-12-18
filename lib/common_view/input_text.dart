import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? iconPrefix;
  final Widget? iconSufix;
  final String hintText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final EdgeInsets? padding;
  final bool isShowSuffix;
  final bool readOnly;
  final Color? fillColor;
  final FocusNode? focusNode;
  final double? fontSize;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final TextStyle? errorStyle;
  final TextStyle? style;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final bool? expands;
  final TextAlign? textAlign;
  final String? initialValue;
  final String? suffixText;

  final int? maxLines;
  final int? minLines;
  final AutovalidateMode? autovalidateMode;
  const InputText({
    Key? key,
    this.controller,
    this.iconPrefix,
    this.iconSufix,
    this.textInputType,
    this.onChanged,
    this.focusNode,
    this.inputFormatters,
    this.obscureText = false,
    this.suffixText,
    required this.hintText,
    this.textInputAction = TextInputAction.next,
    this.padding,
    this.validator,
    this.enabledBorder,
    this.focusedBorder,
    this.expands,
    this.isShowSuffix = false,
    this.readOnly = false,
    this.fillColor,
    this.fontSize,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.errorStyle,
    this.style,
    this.textAlign,
    this.initialValue,
    this.maxLines,
    this.minLines,
    this.onTap,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      inputFormatters: widget.inputFormatters,
      style: widget.style,
      focusNode: widget.focusNode,
      obscureText: widget.isShowSuffix ? obscureText : widget.obscureText,
      autovalidateMode:
          widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      textCapitalization: widget.textCapitalization,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines,
      textAlign: widget.textAlign ?? TextAlign.start,
      expands: widget.expands ?? false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Colors.white,
        prefixIcon: widget.iconPrefix,
        suffixText: widget.suffixText,
        prefixIconConstraints:
            const BoxConstraints(minWidth: 54, minHeight: 46),
        suffixIcon: widget.isShowSuffix ? _buildSuffixIcon() : widget.iconSufix,
        contentPadding: widget.padding,
        filled: true,
        errorStyle: widget.errorStyle,
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Theme.of(context).dividerColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red)),
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return InkWell(
      onTap: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      child: obscureText
          ? const Icon(Icons.visibility_off, color: Colors.blue)
          : const Icon(Icons.visibility, color: Colors.blue),
    );
  }
}

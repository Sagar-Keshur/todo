import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/themes/theme.dart';

class AppPrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final void Function()? onTap;
  final bool obscureText;

  const AppPrimaryTextField({
    super.key,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.autoFocus = false,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    if (labelText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(
              labelText!,
              style: context.textTheme.labelLarge?.copyWith(
                fontSize: 16,
                color: TodoAppThemeData.blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildTextField(context),
        ],
      );
    } else {
      return _buildTextField(context);
    }
  }

  Widget _buildTextField(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      autofocus: autoFocus,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: TodoAppThemeData.basePrimary,
      style: context.textTheme.titleLarge?.copyWith(letterSpacing: 1),
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.textTheme.titleMedium?.copyWith(
          color: context.theme.hintColor,
        ),
        errorStyle: context.textTheme.titleMedium?.copyWith(
          fontSize: 12,
          color: context.colorScheme.error,
        ),
        filled: true,
        fillColor: context.theme.canvasColor,
        border: _outlineInputBorder(TodoAppThemeData.border),
        enabledBorder: _outlineInputBorder(TodoAppThemeData.border),
        errorBorder: _outlineInputBorder(context.colorScheme.error),
        focusedBorder: _outlineInputBorder(TodoAppThemeData.basePrimary),
        focusedErrorBorder: _outlineInputBorder(context.colorScheme.error),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
      onTap: onTap,
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(14),
    );
  }
}

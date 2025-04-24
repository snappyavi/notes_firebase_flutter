import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField({
    super.key,
    this.labelText,
    this.controller,
    this.validator,
    this.onChanged,
    this.filled,
    this.suffixIcon,
    this.fillColor,
    this.autofocus = false,
    this.obscureText = false,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autofocus;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      autofocus: true,

      decoration: InputDecoration(
        labelText: labelText,

        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        //to add a border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary),
        ),
      ),
      validator: validator,

      //validates the textfield for any change
      onChanged: onChanged,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
    );
  }
}

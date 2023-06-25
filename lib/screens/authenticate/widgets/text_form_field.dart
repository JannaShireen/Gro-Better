import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final TextEditingController? controller;
  final int? maxLines;
  final String initialValue;

  const TextFormFieldWidget({
    Key? key,
    required this.hintText,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.initialValue = '',
    this.validator,
    this.onChanged,
    this.maxLength,
    this.controller,
    this.maxLines = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: '',
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.lato(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: kDefaultIconLightColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: kDefaultIconDarkColor, // Change to your desired border color
          ),
        ),
        // prefixIcon: Icon(
        //   icon,
        //   color: Colors.grey,
        // ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 17, horizontal: 14),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      maxLength: maxLength,
    );
  }
}

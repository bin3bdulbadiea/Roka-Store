import 'package:flutter/material.dart';
import 'package:rokastore/consts/colors.dart';

Widget customTextField({
  String? hint,
  TextInputType? keyboardType,
  bool obscureText = false,
  IconData? suffixIcon,
  void Function()? suffixPressed,
  TextEditingController? controller,
  String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  int? maxLength,
  String? label,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            suffixIcon: IconButton(
              onPressed: suffixPressed,
              icon: Icon(suffixIcon),
            ),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            filled: true,
            fillColor: whiteColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: redColor,
              ),
            ),
          ),
        ),
      ],
    );

import 'package:flutter/material.dart';
import 'package:skf_project/core/themes/constant_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.darkGrey,
      cursorHeight: 20,
      decoration: InputDecoration(
        border: _borderStyle(),
        focusedBorder: _borderStyle(),
        errorBorder: _borderStyle(),
        enabledBorder: _borderStyle(),
        disabledBorder: _borderStyle(),
        filled: true,
        fillColor: AppColors.intermediateLightGrey,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.intermediateDarkGrey,
        ),
      ),
    );
  }
  InputBorder _borderStyle(){
    return OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        );
  }
}

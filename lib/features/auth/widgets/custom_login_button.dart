import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skf_project/core/themes/constant_colors.dart';

class CustomLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const CustomLoginButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.lightBlue,
          surfaceTintColor: Colors.transparent,
        ),
        child:child,
      ),
    );
  }
}

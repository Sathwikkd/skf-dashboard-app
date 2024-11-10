import 'package:flutter/material.dart';
import 'package:skf_project/core/themes/constant_colors.dart';


class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.lightBlue,
      strokeCap: StrokeCap.round,
    );
  }
}
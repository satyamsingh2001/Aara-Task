import 'package:aara_task/style/colors/colors_const.dart';
import 'package:flutter/material.dart';

class ConstantContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radiusBorder;
  final double? borderWidth;
  final Color? borderColor;
  final Color? color;
  final Widget? child;

  const ConstantContainer({
    Key? key,
    this.height,
    this.width,
    this.radiusBorder,
    this.borderWidth,
    this.color,
    this.child,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            gradient: const LinearGradient(
              colors: [AppColors.secondary, AppColors.secondary100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(radiusBorder ?? 10),
            border: Border.all(
                color: borderColor ?? AppColors.primary,
                width: borderWidth ?? 2)),
        child: child);
  }
}
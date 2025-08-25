import 'package:flutter/material.dart';
import 'package:taskati/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double hight;
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = 220,
    this.hight = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(width, hight),
      ),
      child: Text(label),
    );
  }
}

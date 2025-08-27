import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.title,
    required this.hintText,
    this.isEnabled = true,
    this.onTap,
    this.suffixIcon,
    this.maxLines = 1,
    this.controller,
    this.validator,
  });

  final String title;
  final String hintText;
  final int maxLines;
  final bool isEnabled;
  final VoidCallback? onTap;
  final Icon? suffixIcon;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Gap(5),
        TextFormField(
          maxLines: maxLines,
          validator: validator,
          onTap: onTap,
          controller: controller,
          style: TextStyles.getBody(color: AppColors.black),
          readOnly: !isEnabled,
          decoration: InputDecoration(
            hintText: hintText,
            // enabled: isEnabled,
          
            suffixIcon: suffixIcon,
          ),
        ),
        Gap(5),
      ],
    );
  }
}

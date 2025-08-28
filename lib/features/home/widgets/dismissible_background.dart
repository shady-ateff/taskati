import 'package:flutter/material.dart';
import 'package:taskati/core/utils/text_styles.dart';

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({
    super.key,
    required this.color,
    required this.radius,
    required this.text,
    required this.icon,
    required this.alignment,
  });

  final Color color;
  final double radius;
  final String text;
  final IconData icon;
  final MainAxisAlignment alignment;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Icon(icon, color: Colors.white),
          Text(text, style: TextStyles.getTitle(color: Colors.white)),
        ],
      ),
    );
  }
}

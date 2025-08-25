import 'package:flutter/material.dart';
import 'package:taskati/core/utils/app_colors.dart';

class ColorSelectionWidget extends StatefulWidget {
  ColorSelectionWidget({super.key, required this.onColorChanged});

  final List<Color> taskColor = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.tetary,
    AppColors.black,
  ];
  final ValueChanged<Color> onColorChanged;

  @override
  State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  var _selectedColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text("Color"),
        Row(
          spacing: 5,
          children: [
            ...List.generate(widget.taskColor.length, (indx) {
              return GestureDetector(
                onTap: () {
                  _selectedColor = widget.taskColor[indx];
                  setState(() {
                    widget.onColorChanged(_selectedColor);
                  });
                },
                child: CircleAvatar(
                  backgroundColor: widget.taskColor[indx],
                  child: _selectedColor == widget.taskColor[indx]
                      ? Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}

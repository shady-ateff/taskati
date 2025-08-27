import 'package:flutter/material.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/utils/app_colors.dart';

class ColorSelectionWidget extends StatefulWidget {
  const ColorSelectionWidget({super.key, required this.onColorChanged});

  final ValueChanged<int> onColorChanged;

  @override
  State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    var taskColor = TaskModel.taskColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Text("Color"),
        Row(
          spacing: 5,
          children: [
            ...List.generate(taskColor.length, (selectedColorIndex) {
              return GestureDetector(
                onTap: () {
                  selectedColor = selectedColorIndex;
                  setState(() {
                    widget.onColorChanged(selectedColor);
                  });
                },
                child: CircleAvatar(
                  backgroundColor: taskColor[selectedColorIndex],
                  child: selectedColor == selectedColorIndex
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

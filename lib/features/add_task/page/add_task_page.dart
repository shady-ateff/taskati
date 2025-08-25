import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/buttons/custom_button.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/widgets/color_selection_widget.dart';
import 'package:taskati/features/add_task/widgets/custom_form_field.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _titleController = TextEditingController();
    var _descriptionController = TextEditingController();
    var _dateController = TextEditingController(
      text: DateFormat('yyyy-MM-d').format(DateTime.now()),
    );
    var _startTimeController = TextEditingController(
      text: DateFormat('HH : MM a').format(DateTime.now()),
    );
    var _endTimeController = TextEditingController(
      text: DateFormat('HH : MM a').format(DateTime.now()),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Add Task", style: TextStyles.getTitle())),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 30,
          children: [
            CustomFormField(
              title: 'Title',
              hintText: 'Enter Title',
              controller: _titleController,
            ),
            CustomFormField(
              title: 'Description',
              hintText: 'Enter Description......',
              maxLines: 4,
              controller: _descriptionController,
            ),
            CustomFormField(
              title: 'Date',
              hintText: '${DateTime.now()}',
              suffixIcon: Icon(Icons.date_range_rounded),
              isEnabled: false,
              controller: _dateController,
              onTap: () async {
                var selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                );
                if (selectedDate != null) {
                  _dateController.text = DateFormat(
                    'yyyy-MM-dd',
                  ).format(selectedDate);
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    title: 'Start Time',
                    hintText: '${DateTime.now()}',
                    suffixIcon: Icon(Icons.watch_later_outlined),
                    isEnabled: false,
                    controller: _startTimeController,
                    onTap: () async {
                      var selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        _startTimeController.text = selectedTime.format(context);
                      }
                    },
                  ),
                ),
                Gap(10),
                Expanded(
                  child: CustomFormField(
                    title: 'Start Time',
                    hintText: '${DateTime.now()}',
                    suffixIcon: Icon(Icons.watch_later_outlined),
                    isEnabled: false,
                    controller: _endTimeController,
                    onTap: () async {
                      var selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        _endTimeController.text = selectedTime.format(context);
                      }
                    },
                  ),
                ),
              ],
            ),
            ColorSelectionWidget(onColorChanged: (color) {}),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomButton(
          label: "Create Task",
          width: double.infinity,
          hight: 50,
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

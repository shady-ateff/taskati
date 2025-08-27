import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/buttons/custom_button.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/helpers.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/widgets/color_selection_widget.dart';
import 'package:taskati/features/add_task/widgets/custom_form_field.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController(text: '');
    var dateController = TextEditingController(
      text: DateFormat('yyyy-MM-d').format(DateTime.now()),
    );
    var startTimeController = TextEditingController(
      text: DateFormat('hh:mm a').format(DateTime.now()),
    );
    var endTimeController = TextEditingController(
      text: DateFormat('hh:mm a').format(DateTime.now()),
    );
    int selectedColor = 0;
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text("Add Task", style: TextStyles.getTitle())),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30,
            children: [
              CustomFormField(
                title: 'Title',
                hintText: 'Enter Title',
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Task Title';
                  } else {
                    return null;
                  }
                },
              ),
              CustomFormField(
                title: 'Description',
                hintText: 'Enter Description......',
                maxLines: 4,
                controller: descriptionController,
              ),
              CustomFormField(
                title: 'Date',
                hintText: '${DateTime.now()}',
                suffixIcon: Icon(Icons.date_range_rounded),
                isEnabled: false,
                controller: dateController,
                onTap: () async {
                  var selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                  );
                  if (selectedDate != null) {
                    dateController.text = DateFormat(
                      'yyyy-MM-dd',
                    ).format(selectedDate);
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomFormField(
                      title: 'Start Time',
                      hintText: '${DateTime.now()}',
                      suffixIcon: Icon(Icons.watch_later_outlined),
                      isEnabled: false,
                      controller: startTimeController,
                      validator: (value) {
                        if (stringToTimeOfDay(endTimeController.text).compareTo(stringToTimeOfDay(startTimeController.text),) == -1) {
                          return 'End time must be after start time';
                        } else {
                          return null;
                        }
                      },
                      onTap: () async {
                        var selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          startTimeController.text = selectedTime.format(
                            context,
                          );
                        }
                      },
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: CustomFormField(
                      title: 'End Time',
                      hintText: '${DateTime.now()}',
                      suffixIcon: Icon(Icons.watch_later_outlined),
                      isEnabled: false,
                      validator: (value) {
                        if (stringToTimeOfDay(endTimeController.text).compareTo(stringToTimeOfDay(startTimeController.text),) == -1) {
                          return 'End time must be after start time';
                        }
                        // else if(stringToTimeOfDay(endTimeController.text).compareTo(TimeOfDay.now(),) == -1){
                        //   return 'End time must be after now';
                        // } 
                        else {
                          return null;
                        }
                      },
                      controller: endTimeController,
                      onTap: () async {
                        var selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          endTimeController.text = selectedTime.format(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              ColorSelectionWidget(
                onColorChanged: (selectedColorIndex) {
                  selectedColor = selectedColorIndex;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomButton(
          label: "Create Task",
          width: double.infinity,
          hight: 50,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              var id = DateTime.now().millisecondsSinceEpoch.toString();
              HiveHelper.cacheTask(
                id,
                TaskModel(
                  id: id,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                  colorIndex: selectedColor,
                  isCompleted: false,
                ),
              );

              Navigator.of(context).pop();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

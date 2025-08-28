import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/buttons/custom_button.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/helpers.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/widgets/color_selection_widget.dart';
import 'package:taskati/features/add_task/widgets/custom_form_field.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key, this.task});

  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController(
      text: task != null ? task!.title : '',
    );
    var descriptionController = TextEditingController(
      text: task != null ? task!.description : '',
    );
    var dateController = TextEditingController(
      text: task != null
          ? task!.date
          : DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    var startTimeController = TextEditingController(
      text: task != null
          ? task!.startTime
          : DateFormat('hh:mm a').format(DateTime.now()),
    );
    var endTimeController = TextEditingController(
      text: task != null
          ? task!.endTime
          : DateFormat(
              'hh:mm a',
            ).format(DateTime.now().add(Duration(minutes: 15))),
    );
    int selectedColor = task != null ? task!.colorIndex : 0;

    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text("Add Task", style: TextStyles.getTitle())),
      body: SingleChildScrollView(
        child: Padding(
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
                      initialDate: task != null
                          ? DateTime.parse(task!.date)
                          : DateTime.now(),
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
                          if (stringToTimeOfDay(endTimeController.text).compareTo(
                                stringToTimeOfDay(startTimeController.text),
                              ) ==
                              -1) {
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
                          if (stringToTimeOfDay(endTimeController.text).compareTo(
                                stringToTimeOfDay(startTimeController.text),
                              ) ==
                              -1) {
                            return 'End time must be after start time';
                          } else {
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
                  initialColor: selectedColor,
                  onColorChanged: (selectedColorIndex) {
                    selectedColor = selectedColorIndex;
                  },
                ),
                Gap(60),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomButton(
          label: "Create Task",
          width: double.infinity,
          height: 50,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (task != null) {

                HiveHelper.updateTask(
                  task!.copyWith(
                    title: titleController.text,
                    description: descriptionController.text,
                    date: dateController.text,
                    startTime: startTimeController.text,
                    endTime: endTimeController.text,
                    colorIndex: selectedColor,
                  ),
                );
              } else {
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
              }

              Navigator.of(context).pop();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

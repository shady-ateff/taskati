import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/extentions/dialogs.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/page/add_task_page.dart';
import 'package:taskati/features/home/page/home_page.dart';
import 'package:taskati/features/home/widgets/dismissible_background.dart';
import 'package:taskati/features/home/widgets/task_card.dart';

class TaskBuilder extends StatelessWidget {
  const TaskBuilder({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          confirmDismiss: (direction) async {
            if (tasks[index].isCompleted &&
                direction == DismissDirection.startToEnd) {
              return false;
            } else {
              return true;
            }
          },
          key: UniqueKey(),
          background: DismissibleBackground(
            alignment: MainAxisAlignment.start,
            color: Colors.green,
            radius: 25,
            text: tasks[index].isCompleted
                ? ' Already Completed'
                : ' Completed',
            icon: Icons.check_circle,
          ),
          secondaryBackground: DismissibleBackground(
            alignment: MainAxisAlignment.end,
            color: Colors.red,
            radius: 25,
            text: ' Delete',
            icon: Icons.delete,
          ),
          onDismissed: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              await HiveHelper.updateTask(
                tasks[index].copyWith(isCompleted: true),
              );
              log('Task Completed');
            } else {
              await HiveHelper.deleteTask(tasks[index].id);
              log('Task Deleted');
            }
          },
          child: GestureDetector(
            onTap: () {
              log('Task Tapped');
              if (tasks[index].isCompleted) {
                errorDialog(context, "Cannot edit a completed task");
                return;
              }
              pushTo(context, AddTaskPage(task: tasks[index]));
            },
            child: TaskCard(task: tasks[index]),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Gap(10);
      },
      itemCount: tasks.length,
    );
  }
}

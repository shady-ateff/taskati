import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/widgets/date_header_widget.dart';
import 'package:taskati/features/home/widgets/home_header_widget.dart';
import 'package:taskati/features/home/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedDay = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              HomeHeaderWidget(),
              Gap(20),
              DateHeaderWidget(),
              Gap(15),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primary,
                selectedTextColor: AppColors.white,
                height: 90,
                width: 75,
                onDateChange: (selectedDate) {
                  setState(() {
                    selectedDay = DateFormat('yyyy-MM-dd').format(selectedDate);
                    log(selectedDay);
                  });
                },
              ),
              Gap(30),

              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: HiveHelper.taskBox.listenable(),
                  builder: (BuildContext context, value, Widget? child) {
                    var tasks = value.values.toList();

                    tasks.sort(
                      (a, b) =>  a.isCompleted ? 1 : -1,
                    );
                    tasks = tasks
                        .where((element) => element.date == selectedDay)
                        .toList();
                    if (tasks.isEmpty) {
                      return EmptyTasks();
                    }
                    return TaskBuilder(tasks: tasks);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyTasks extends StatelessWidget {
  const EmptyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('assets/lotties/empty.json', fit: BoxFit.cover),
        Text(
          "No Tasks Yet!\nAdd New Task",
          textAlign: TextAlign.center,
          style: TextStyles.getTitle(),
        ),
        Gap(170),
      ],
    );
  }
}

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
          child: TaskCard(task: tasks[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Gap(10);
      },
      itemCount: tasks.length,
    );
  }
}

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

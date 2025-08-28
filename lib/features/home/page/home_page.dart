import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/page/add_task_page.dart';
import 'package:taskati/features/home/builders/task_builder.dart';
import 'package:taskati/features/home/widgets/date_header_widget.dart';
import 'package:taskati/features/home/widgets/empty_tasks.dart';
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
                dayTextStyle: TextStyles.getSmall(fontSize: 12),
                monthTextStyle:TextStyles.getSmall(fontSize: 12),
                dateTextStyle: TextStyles.getTitle(fontSize: 20),
                deactivatedColor: AppColors.grey,
                daysCount: 100,
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

                    tasks.sort((a, b) => a.isCompleted ? 1 : -1);
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

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/widgets/date_header_widget.dart';
import 'package:taskati/features/home/widgets/home_header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                onDateChange: (selectedDate) {},
              ),
              Gap(30),

              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return TaskCard();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Gap(10);
                  },
                  itemCount: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      // height: 110,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task Title ",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.getTitle(
                    color: AppColors.white,
                  ),
                ),
                Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.white,
                    ),
                    Text(
                      "2:20 - 4:20",
                      style: TextStyles.getSmall(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Task Description",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.getBody(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: 1,
            height: 60,
            color: AppColors.white,
          ),
          // Gap(8),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              "TODO",
              style: TextStyles.getBody(color: AppColors.white , fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

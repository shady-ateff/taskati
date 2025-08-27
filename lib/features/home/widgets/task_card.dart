import 'package:flutter/material.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/utils/app_colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(16),
      // height: 110,
      decoration: BoxDecoration(
        color: task.isCompleted? Colors.grey : TaskModel.taskColor[task.colorIndex],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.getTitle(color: AppColors.white),
                ),
                Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.access_time, size: 16, color: AppColors.white),
                    Text(
                      "${task.startTime} - ${task.endTime}",
                      style: TextStyles.getSmall(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  task.description.isNotEmpty
                      ? task.description
                      : "No Description",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.getBody(color: AppColors.white),
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
              task.isCompleted?'Completed':"TODO",
              style: TextStyles.getBody(color: AppColors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

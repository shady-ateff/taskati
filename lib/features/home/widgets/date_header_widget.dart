import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/buttons/custom_button.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/page/add_task_page.dart';

class DateHeaderWidget extends StatelessWidget {
  const DateHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${DateFormat.yMMMMd().format(DateTime.now())} ",
                style: TextStyles.getTitle(fontWeight: FontWeight.w600),
              ),
              Gap(5),
              Text("Today"),
              
            ],
          ),
        ),
        CustomButton(label: 'Add Task', onPressed: () {
          pushTo(context, AddTaskPage()).then((p) {
            
          });
        } ,width: 2,),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/utils/text_styles.dart';

class EmptyTasks extends StatelessWidget {
  const EmptyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
      ),
    );
  }
}

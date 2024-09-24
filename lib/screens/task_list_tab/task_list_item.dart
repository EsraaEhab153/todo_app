import 'package:flutter/material.dart';

import '../../styling/app_colors.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height * 0.13,
      width: width * 0.8,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: width * 0.009,
            height: height * 0.07,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Task Title',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.primaryColor),
                ),
                Text(
                  'description',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            width: width * 0.16,
            height: height * 0.035,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.check,
              color: AppColors.whiteColor,
              size: width * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}

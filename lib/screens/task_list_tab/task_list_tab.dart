import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/language_provider.dart';
import 'package:todo_app/screens/task_list_tab/task_list_item.dart';

import '../../styling/app_colors.dart';

class TaskListTab extends StatelessWidget {
  const TaskListTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var langProvider = Provider.of<AppLanguageProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: height * 0.12,
              color: AppColors.primaryColor,
            ),
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
              },
              locale: langProvider.appLanguage,
              headerProps: const EasyHeaderProps(
                selectedDateStyle: TextStyle(
                  color: AppColors.whiteColor,
                ),
                monthStyle: TextStyle(
                  color: AppColors.whiteColor,
                ),
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDMY(),
              ),
              dayProps: EasyDayProps(
                height: height * 0.09,
                dayStructure: DayStructure.dayStrDayNum,
                activeDayStyle: const DayStyle(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff0bc8de),
                        AppColors.primaryColor,
                      ],
                    ),
                  ),
                ),
                inactiveDayStyle: const DayStyle(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => TaskListItem(),
            itemCount: 30,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/styling/app_colors.dart';

import '../provider/task_list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var chosenDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late TaskListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    listProvider = Provider.of<TaskListProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  onChanged: (text) {
                    title = text;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.add_task_title,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: themeProvider.isDark()
                                ? AppColors.whiteColor
                                : AppColors.blackColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: themeProvider.isDark()
                                ? AppColors.whiteColor
                                : AppColors.blackColor)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: themeProvider.isDark()
                                ? AppColors.whiteColor
                                : AppColors.blackColor)),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .validation_task_title_msg;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                TextFormField(
                  onChanged: (text) {
                    description = text;
                  },
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.add_task_description,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: themeProvider.isDark()
                                ? AppColors.whiteColor
                                : AppColors.blackColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: themeProvider.isDark()
                                ? AppColors.whiteColor
                                : AppColors.blackColor)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: themeProvider.isDark()
                                ? AppColors.whiteColor
                                : AppColors.blackColor)),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .validation_task_description_msg;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    showCalender();
                  },
                  child: Text(
                    '${chosenDate.day}/${chosenDate.month}/${chosenDate.year}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.add_button,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCalender() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: const TextTheme(
              headlineMedium: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    chosenDate = selectedDate ?? chosenDate;
    setState(() {});
  }

  void addTask() {
    if (_formKey.currentState?.validate() == true) {
      Task task =
          Task(title: title, description: description, dateTime: chosenDate);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      FirebaseUtils.addTask(task, userProvider.currentUser!.id!).then((value) {
        print('Task Added successfully');
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
        Navigator.pop(context);
      }).timeout(const Duration(seconds: 1), onTimeout: () {
        print('Task Added successfully');
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}

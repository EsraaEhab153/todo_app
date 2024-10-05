import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';

import '../../model/task_model.dart';
import '../../styling/app_colors.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit_task';
  Task? task;

  EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var chosenDate = DateTime.now();
  late String titleValue;

  late String descValue;

  @override
  void initState() {
    chosenDate = widget.task?.dateTime ?? DateTime.now();
    titleValue = widget.task?.title ?? '';
    descValue = widget.task?.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todo_app),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.12,
                  color: AppColors.primaryColor,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: height * 0.04,
                    horizontal: width * 0.08,
                  ),
                  padding: EdgeInsets.all(width * 0.09),
                  width: width * 0.85,
                  height: height * 0.7,
                  decoration: BoxDecoration(
                    color: themeProvider.isDark()
                        ? AppColors.darkGrayColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Edit Task',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              initialValue: titleValue,
                              onChanged: (text) {
                                titleValue = text;
                              },
                              decoration: InputDecoration(
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
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                            ),
                            TextFormField(
                              initialValue: descValue,
                              onChanged: (text) {
                                descValue = text;
                              },
                              decoration: InputDecoration(
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
                                editTask();
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                'Save Changes',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showCalender() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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

  void editTask() {
    Task task = Task(
        title: titleValue,
        description: descValue,
        dateTime: chosenDate,
        id: widget.task!.id,
        isDone: widget.task!.isDone);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var listProvider = Provider.of<TaskListProvider>(context, listen: false);

    if (userProvider.currentUser != null &&
        userProvider.currentUser!.id!.isNotEmpty) {
      FirebaseUtils.editTask(task: task, uid: userProvider.currentUser!.id!)
          .then((value) {
        print('Task Edited successfully');
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
        Navigator.pop(context);
      }).timeout(const Duration(seconds: 1), onTimeout: () {
        print('Task Edited successfully');
        listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
      });
    } else {
      print('Error: User ID is missing.');
      Navigator.pop(context);
      return;
    }
  }
}

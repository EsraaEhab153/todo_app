import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/task_list_tab/edit_task.dart';

import '../../provider/task_list_provider.dart';
import '../../provider/user_provider.dart';
import '../../styling/app_colors.dart';

class TaskListItem extends StatefulWidget {
  Task task;

  TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var listProvider = Provider.of<TaskListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTask(
              task: widget.task,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Slidable(
          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            extentRatio: 0.25,
            // A motion is a widget used to control how the pane animates.
            motion: const BehindMotion(),
            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                onPressed: (context) {
                  FirebaseUtils.deleteTask(
                          widget.task, userProvider.currentUser!.id!)
                      .then((value) {
                    print('Task Deleted Successfully');
                    listProvider.getAllTasksFromFireStore(
                        userProvider.currentUser!.id!);
                  }).timeout(Duration(seconds: 1), onTimeout: () {
                    print('Task Deleted Successfully');
                    listProvider.getAllTasksFromFireStore(
                        userProvider.currentUser!.id!);
                  });
                },
                backgroundColor: AppColors.redColor,
                foregroundColor: AppColors.whiteColor,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            height: height * 0.13,
            width: width * 0.89,
            decoration: BoxDecoration(
              color: themeProvider.isDark()
                  ? AppColors.darkGrayColor
                  : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  width: width * 0.009,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                      color: widget.task.isDone
                          ? AppColors.greenColor
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.task.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: widget.task.isDone
                                        ? AppColors.greenColor
                                        : AppColors.primaryColor,
                                  ),
                        ),
                        Text(
                          widget.task.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.task.isDone = !widget.task.isDone;
                    FirebaseUtils.updateIsDone(
                        uid: userProvider.currentUser!.id!, task: widget.task);
                    setState(() {});
                  },
                  child: widget.task.isDone
                      ? Text(
                          'Done!',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.greenColor),
                        )
                      : Container(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

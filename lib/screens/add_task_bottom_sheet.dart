import 'package:flutter/material.dart';
import 'package:todo_app/styling/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var chosenDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Column(
        children: [
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Add Task Title',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please Enter Task Title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Add Task Description',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please Enter Task Description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'Select Date',
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
                    'Add',
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
    );
    chosenDate = selectedDate ?? chosenDate;
    setState(() {});
  }

  void addTask() {
    if (_formKey.currentState?.validate() == true) {}
  }
}

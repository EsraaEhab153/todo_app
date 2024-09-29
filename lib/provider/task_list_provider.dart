import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/task_model.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFireStore() async {
    // get tasks from fireStore
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTaskCollection().get();
    taskList = querySnapshot.docs.map((doc) => doc.data()).toList();
    // filter the tasks based on user selected date
    taskList = taskList.where((task) {
      if (selectedDate.day == task.dateTime.day &&
          selectedDate.month == task.dateTime.month &&
          selectedDate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();
    // sorting the list based on dateTime
    taskList.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changDate(DateTime newDate) {
    selectedDate = newDate;
    getAllTasksFromFireStore();
  }
}

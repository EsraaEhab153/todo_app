import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/task_model.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  static Future<void> addTask(Task task) {
    var taskCollection = getTaskCollection(); // get collection
    DocumentReference<Task> taskDocRef = taskCollection.doc(); // get document
    task.id = taskDocRef.id; // generate id and store it at id of object
    return taskDocRef.set(task);
  }

  static Future<void> deleteTask(Task task) {
    return getTaskCollection().doc(task.id).delete();
  }
}

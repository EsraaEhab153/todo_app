import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/user.dart';

import 'model/task_model.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return getUsersCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  static Future<void> addTask(Task task, String uid) {
    var taskCollection = getTaskCollection(uid); // get collection
    DocumentReference<Task> taskDocRef = taskCollection.doc(); // get document
    task.id = taskDocRef.id; // generate id and store it at id of object
    return taskDocRef.set(task);
  }

  static Future<void> deleteTask(Task task, String uid) {
    return getTaskCollection(uid).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, options) => user.toJson());
  }

  static Future<void> addUserToFireStore(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFireStore(String userId) async {
    var querySnapshot = await getUsersCollection().doc(userId).get();
    return querySnapshot.data();
  }

  static Future<void> updateIsDone({required String uid, required Task task}) {
    return getTaskCollection(uid).doc(task.id).update({'isDone': task.isDone});
  }

  static Future<void> editTask({required String uid, required Task task}) {
    return getTaskCollection(uid).doc(task.id).update(task.toJson());
  }
}

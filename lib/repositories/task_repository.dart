import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/utils/firebase_collection.dart';
import 'package:todo/models/task_model.dart';

class TaskRepository {
  final CollectionReference _firestore = FirebaseFirestore.instance.collection(FirebaseCollection.task);

  Future<void> create(Task task) {
    task = task.copyWith(id: _firestore.doc().id, uid: preferences.uid);
    return _firestore.doc(task.id).set(task.toMap());
  }

  Future<void> update(Task task) {
    return _firestore.doc(task.id).update(task.toMap());
  }

  Future<List<Task>> fetch() async {
    return _firestore
        .where('uid', isEqualTo: preferences.uid)
        .withConverter(
          fromFirestore: (snapshot, options) => Task.fromMap(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toMap(),
        )
        .get()
        .then((value) {
      return List<Task>.from(value.docs.map((e) => e.data()));
    });
  }
}

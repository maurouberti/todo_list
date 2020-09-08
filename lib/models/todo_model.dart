import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  DocumentReference reference;
  String id;
  String title;
  bool check;

  TodoModel({this.reference, this.id, this.title, this.check = false});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
      reference: doc.reference,
      id: doc.id,
      title: doc.data()['title'],
      check: doc.data()['check'],
    );
  }

  save() async {
    if (reference == null) {
      await FirebaseFirestore.instance
          .collection('todo')
          .add({'title': title, 'check': check});
    } else {
      reference.update({'title': title, 'check': check});
    }
  }

  delete() {
    return reference.delete();
  }

  onClickCheck() {
    reference.update({'check': !check});
  }
}

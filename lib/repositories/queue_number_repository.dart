import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eaki_admin/models/dto/queue_number_dto.dart';
import 'package:eaki_admin/models/entities/queue_number.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

final queueNumberRepository = Provider.autoDispose(
  (ref) => QueueNumberRepository(ref, FirebaseFirestore.instance),
);

class QueueNumberRepository {
  final AutoDisposeProviderRef ref;
  final FirebaseFirestore db;
  late Stream<List<QueueNumber>> stream;

  QueueNumberRepository(this.ref, this.db);

  getCurrentQueueNumbers(VisitPurpose visitPurpose) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    final collection = db.collection("queue_numbers");

    final Stream<QuerySnapshot> snapshots = collection
        .where("date", isGreaterThan: date)
        //.where("visit_purpose", isEqualTo: visitPurpose.name)
        .orderBy("date")
        .snapshots();

    stream = snapshots.map((event) => event.docs
        .mapIndexed(
          (index, doc) => QueueNumber.fromDTO(
            QueueNumberDTO.fromMap(doc.data() as Map<String, dynamic>),
            index + 1,
            doc.id,
          ),
        )
        .toList());
  }

  callQueueNumber(QueueNumber queueNumber) {
    final collection = db.collection("queue_numbers");
    collection.doc(queueNumber.id).update({"date_called": DateTime.now()});
  }
}

import 'package:eaki_admin/models/entities/queue_number.dart';
import 'package:eaki_admin/repositories/queue_number_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final queueNumbersProvider = StreamProvider<List<QueueNumber>>((ref) {
  ref.read(queueNumberRepository).getCurrentQueueNumbers(VisitPurpose.appointment);
  return ref.read(queueNumberRepository).stream;
});

import 'package:eaki_admin/models/entities/queue_number.dart';
import 'package:eaki_admin/repositories/queue_number_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final queueNumberVM = Provider.autoDispose(
  (ref) => QueueNumberVM(ref),
);

class QueueNumberVM {
  final AutoDisposeProviderRef ref;

  QueueNumberVM(this.ref);

  QueueNumber? getCurrentQueueNumber(List<QueueNumber> list) {
    if (list.isEmpty) {
      return null;
    }
    final dateCalledList = list.where((number) => number.dateCalled != null).toList();
    dateCalledList.sort((a, b) => a.dateCalled!.compareTo(b.dateCalled!));
    return dateCalledList.last;
  }

  List<QueueNumber> getQueueNumberHistoric(List<QueueNumber> list) {
    return list.where((number) => number.dateCalled != null).toList();
  }

  List<QueueNumber> getQueueNumberRemaining(List<QueueNumber> list) {
    return list.where((number) => number.dateCalled == null).toList();
  }

  void callNextQueueNumber(List<QueueNumber> list) {
    final nextQueueNumber = list.where((number) => number.dateCalled == null).first;
    ref.read(queueNumberRepository).callQueueNumber(nextQueueNumber);
  }

  void recallQueueNumber(QueueNumber queueNumber) {
    ref.read(queueNumberRepository).callQueueNumber(queueNumber);
  }
}

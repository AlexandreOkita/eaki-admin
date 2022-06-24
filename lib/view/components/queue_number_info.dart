import 'package:eaki_admin/models/entities/queue_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueNumberInfo extends ConsumerWidget {
  final QueueNumber currentQueueNumber;
  const QueueNumberInfo({required this.currentQueueNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QueueNumberAtomicInfo(data: currentQueueNumber.hcNumber ?? "-", info: "HC"),
        QueueNumberAtomicInfo(data: currentQueueNumber.name ?? "-", info: "Nome"),
        QueueNumberAtomicInfo(data: currentQueueNumber.visitPurpose.name.toUpperCase(), info: "Tipo"),
      ],
    );
  }
}

class QueueNumberAtomicInfo extends ConsumerWidget {
  final String data;
  final String info;

  const QueueNumberAtomicInfo({Key? key, required this.data, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(info, style: theme.headline6,),
        const SizedBox(height: 8,),
        Text(data, style: theme.bodyText1,),
      ],
    );
  }
}

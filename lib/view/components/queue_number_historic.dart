import 'package:eaki_admin/models/entities/queue_number.dart';
import 'package:eaki_admin/viewmodel/queue_number_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueNumberHistoric extends ConsumerWidget {
  final List<QueueNumber> queueNumberList;
  const QueueNumberHistoric({required this.queueNumberList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reversedQueueNumberList = queueNumberList.reversed.toList();
    return ListView.separated(
        itemBuilder: ((context, index) => Container(
              color: theme.primaryColor.withOpacity(0.25),
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    reversedQueueNumberList[index].hcNumber ?? "-",
                    style: theme.textTheme.bodyText1,
                  ),
                  Text(
                    reversedQueueNumberList[index].name ?? "-",
                    style: theme.textTheme.bodyText1,
                  ),
                  Text(
                    reversedQueueNumberList[index].number.toString(),
                    style: theme.textTheme.bodyText1,
                  ),
                  Text(
                    reversedQueueNumberList[index].visitPurpose.name.toUpperCase(),
                    style: theme.textTheme.bodyText1,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          ref.read(queueNumberVM).recallQueueNumber(reversedQueueNumberList[index]),
                      child: Text(
                        "Rechamar",
                        style: theme.textTheme.button,
                      ))
                ],
              ),
            )),
        separatorBuilder: (context, _) => const SizedBox(
              height: 16,
            ),
        itemCount: queueNumberList.length);
  }
}

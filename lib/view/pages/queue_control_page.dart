import 'package:eaki_admin/providers/queue_number_provider.dart';
import 'package:eaki_admin/view/components/current_queue_number.dart';
import 'package:eaki_admin/view/components/eaki_admin_scaffold.dart';
import 'package:eaki_admin/view/components/next_queue_button.dart';
import 'package:eaki_admin/view/components/queue_number_historic.dart';
import 'package:eaki_admin/view/components/queue_number_info.dart';
import 'package:eaki_admin/viewmodel/queue_number_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueControlPage extends ConsumerWidget {
  const QueueControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return ref.watch(queueNumbersProvider).when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Scaffold(
            body: Center(child: Text("$e\n\n$st")),
          ),
          data: (data) {
            final currentQueueNumber = ref.read(queueNumberVM).getCurrentQueueNumber(data);
            final remainingQueueNumbers = ref.read(queueNumberVM).getQueueNumberRemaining(data);
            return EakiAdminScaffold(
              title: "Controle da Fila",
              body: Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(64.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CurrentQueueNumber(
                                  currentQueueNumber: currentQueueNumber?.number,
                                ),
                                QueueNumberInfo(
                                  currentQueueNumber: currentQueueNumber,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Center(
                                  child: NextQueueButton(
                            onPressed: remainingQueueNumbers.isEmpty
                                ? null
                                : () => ref.read(queueNumberVM).callNextQueueNumber(data),
                          )))
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: theme.primaryColor,
                      child: Center(
                        child: Text(
                          "Histórico",
                          style: theme.textTheme.button,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: QueueNumberHistoric(
                        queueNumberList: ref.read(queueNumberVM).getQueueNumberHistoric(data),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
  }
}

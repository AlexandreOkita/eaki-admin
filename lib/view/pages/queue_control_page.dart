import 'package:eaki_admin/models/entities/queue_number.dart';
import 'package:eaki_admin/providers/queue_number_provider.dart';
import 'package:eaki_admin/view/components/current_queue_number.dart';
import 'package:eaki_admin/view/components/eaki_admin_scaffold.dart';
import 'package:eaki_admin/view/components/next_queue_button.dart';
import 'package:eaki_admin/view/components/queue_number_historic.dart';
import 'package:eaki_admin/view/components/queue_number_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueControlPage extends ConsumerWidget {
  const QueueControlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return ref.watch(queueNumbersProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (e, st) => Scaffold(
            body: Center(child: Text("$e\n\n$st")),
          ),
          data: (data) {
            print(data);
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
                                const CurrentQueueNumber(
                                  currentQueueNumber: 45,
                                ),
                                QueueNumberInfo(
                                  currentQueueNumber: QueueNumber(
                                    date: DateTime.now(),
                                    visitPurpose: VisitPurpose.appointment,
                                    number: 23,
                                    id: "ads1231",
                                    dateCalled: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: Center(child: NextQueueButton()))
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
                      child: QueueNumberHistoric(queueNumberList: data),
                    ),
                  )
                ],
              ),
            );
          },
        );
  }
}

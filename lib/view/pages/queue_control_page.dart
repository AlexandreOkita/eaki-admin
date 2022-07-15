// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:eaki_admin/view/components/current_queue.dart';
import 'package:eaki_admin/view/components/queue_history_pair_button.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:js' as js;
import 'dart:html' as html;
import 'package:eaki_admin/models/entities/queue_number.dart';
import 'package:eaki_admin/providers/queue_number_provider.dart';
import 'package:eaki_admin/view/components/current_queue_number.dart';
import 'package:eaki_admin/view/components/eaki_admin_scaffold.dart';
import 'package:eaki_admin/view/components/next_queue_button.dart';
import 'package:eaki_admin/view/components/queue_number_historic.dart';
import 'package:eaki_admin/view/components/queue_number_info.dart';
import 'package:eaki_admin/viewmodel/queue_number_vm.dart';

class QueueControlPage extends ConsumerStatefulWidget {
  const QueueControlPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QueueControlPageState();
}

class _QueueControlPageState extends ConsumerState<QueueControlPage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    final List<SideMenuItem> items = [
      SideMenuItem(
        onTap: () {
          page.jumpToPage(0);
        },
        title: "Todas as Senhas",
        icon: const Icon(Icons.all_inbox),
        priority: 0,
      ),
      SideMenuItem(
        onTap: () {
          page.jumpToPage(1);
        },
        title: "Consulta Agendada",
        icon: const Icon(Icons.calendar_today),
        priority: 1,
      ),
      SideMenuItem(
        onTap: () {
          page.jumpToPage(2);
        },
        title: "Procedimentos",
        icon: const Icon(Icons.healing),
        priority: 2,
      ),
      SideMenuItem(
        onTap: () => js.context.callMethod('open', ['https://eaki-data.web.app/']),
        title: "Analisar Dados",
        icon: const Icon(Icons.data_array),
        priority: 3,
      ),
      SideMenuItem(
        onTap: () {
          html.window.open('https://eaki-admin-unicamp.web.app/#/exhibition', 'new tab');
        },
        title: "Modo Exibição",
        icon: const Icon(Icons.tv),
        priority: 4,
      ),
    ];
    return EakiAdminScaffold(
        title: "Controle da Fila",
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SideMenu(
                items: items,
                style: SideMenuStyle(
                  displayMode: SideMenuDisplayMode.auto,
                  hoverColor: Colors.blue[100],
                  selectedColor: Theme.of(context).primaryColor,
                  selectedTitleTextStyle: const TextStyle(color: Colors.white),
                  selectedIconColor: Colors.white,
                ),
                controller: page,
              ),
              const VerticalDivider(),
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: page,
                children: [
                  QueueControlScreen(filterFunction: (q) => true),
                  QueueControlScreen(
                      filterFunction: (q) => q.visitPurpose == VisitPurpose.appointment),
                  QueueControlScreen(
                      filterFunction: (q) => q.visitPurpose == VisitPurpose.procedure),
                ],
              ))
            ],
          ),
        ));
  }
}

class QueueControlScreen extends ConsumerWidget {
  bool Function(QueueNumber) filterFunction;

  QueueControlScreen({
    Key? key,
    required this.filterFunction,
  }) : super(key: key);

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
            data = data.where(filterFunction).toList();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48),
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
                                const QueueHistoryPairButton(),
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
                          ref.watch(showHistoryState) ? "Histórico" : "Fila",
                          style: theme.textTheme.button,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ref.watch(showHistoryState)
                          ? QueueNumberHistoric(
                              queueNumberList: ref.read(queueNumberVM).getQueueNumberHistoric(data),
                            )
                          : CurrentQueue(
                              queueNumberList:
                                  ref.read(queueNumberVM).getQueueNumberRemaining(data),
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

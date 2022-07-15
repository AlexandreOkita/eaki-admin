import 'package:eaki_admin/providers/queue_number_provider.dart';
import 'package:eaki_admin/view/components/eaki_admin_scaffold.dart';
import 'package:eaki_admin/viewmodel/queue_number_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueTVPage extends ConsumerWidget {
  const QueueTVPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return ref.watch(queueNumbersProvider).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Scaffold(
              body: Center(child: Text("$e\n\n$st")),
            ),
        data: (data) {
          final currentQueueNumber = ref.read(queueNumberVM).getCurrentQueueNumber(data);
          return EakiAdminScaffold(
            implyLeading: false,
            title: "Senha Atual",
            body: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  currentQueueNumber?.number.toString() ?? "",
                  style: textTheme.headline1,
                ),
                const SizedBox(height: 30),
                Text("Última Senha Chamada", style: textTheme.headline6),
              ]),
            ),
          );
        });
  }
}

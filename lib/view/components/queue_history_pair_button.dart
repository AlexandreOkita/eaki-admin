import 'package:eaki_admin/providers/queue_number_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueHistoryPairButton extends ConsumerWidget {
  const QueueHistoryPairButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return ToggleButtons(
      isSelected: [!ref.watch(showHistoryState), ref.watch(showHistoryState)],
      selectedColor: Colors.amber,
      borderRadius: BorderRadius.circular(10),
      onPressed: (index) => {
        if (index == 0)
          {ref.read(showHistoryState.notifier).state = false}
        else
          {ref.read(showHistoryState.notifier).state = true}
      },
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Fila",
            style: textTheme.headline6,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Histórico",
            style: textTheme.headline6,
          ),
        ),
      ],
    );
  }
}

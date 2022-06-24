import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentQueueNumber extends ConsumerWidget {
  final int currentQueueNumber;
  const CurrentQueueNumber({required this.currentQueueNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Senha atual:", style: textTheme.headline3),
        const SizedBox(width: 20),
        Text(currentQueueNumber.toString(), style: textTheme.headline3),
      ],
    );
  }
}

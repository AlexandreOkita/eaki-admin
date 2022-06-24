import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextQueueButton extends ConsumerWidget {
  final void Function()? onPressed;
  const NextQueueButton({this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(onPressed: onPressed, child: const Text("Próxima Senha"));
  }
}

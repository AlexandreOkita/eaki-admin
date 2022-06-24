import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EakiAdminScaffold extends ConsumerWidget {
  final Widget body;
  final String title;
  const EakiAdminScaffold({required this.title, required this.body, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: screen.width * 0.1, vertical: screen.height * 0.05),
        child: body,
      ),
    );
  }
}

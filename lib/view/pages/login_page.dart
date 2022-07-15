import 'package:eaki_admin/providers/auth_provider.dart';
import 'package:eaki_admin/repositories/auth_repository.dart';
import 'package:eaki_admin/repositories/id_repository.dart';
import 'package:eaki_admin/view/components/eaki_admin_scaffold.dart';
import 'package:eaki_admin/view/components/error_screen.dart';
import 'package:eaki_admin/view/components/loading_screen.dart';
import 'package:eaki_admin/view/pages/queue_control_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(isLoggedState)) {
      return const QueueControlPage();
    }
    return ref.watch(checkTokenProvider).when(
          error: (e, st) => ErrorScreen(st, e),
          loading: () => const LoadingScreen(),
          data: (tokenValid) {
            if (tokenValid) {
              return const QueueControlPage();
            }
            return const LoginScreen();
          },
        );
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return EakiAdminScaffold(
      implyLeading: true,
      title: "Login",
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: screen.width * 0.1, vertical: screen.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                "ÉAKI ADMIN",
                style: textTheme.headline1,
              ),
            ),
            Flexible(
              flex: 3,
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screen.width * 0.2),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Email",
                          label: Text("Email"),
                        ),
                        onChanged: (s) => setState(() {
                          email = s;
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Senha",
                          label: Text("Senha"),
                        ),
                        obscureText: true,
                        onChanged: (s) => setState(() {
                          password = s;
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: password != null && password != "" && email != null && email != ""
                    ? () async {
                        if (await ref.read(authRepository).login(email!, password!)) {
                          ref.read(isLoggedState.notifier).state = true;
                          ref.read(idRepository).save(password!);
                        }
                      }
                    : null,
                child: const Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

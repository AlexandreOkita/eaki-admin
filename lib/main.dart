import 'package:eaki_admin/firebase_options.dart';
import 'package:eaki_admin/view/pages/login_page.dart';
import 'package:eaki_admin/view/pages/queue_control_page.dart';
import 'package:eaki_admin/view/pages/queue_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: EakiAdminMainWidget()));
}

class EakiAdminMainWidget extends StatelessWidget {
  const EakiAdminMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eaki Admin',
      theme: ThemeData(
        primaryColor: const Color(0xff0E4DA4),
        errorColor: const Color(0xffE74C3C),
        scaffoldBackgroundColor: const Color(0xF9FFFFFF),
        fontFamily: "Inter",
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff263238),
          ),
          headline3: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff263238),
          ),
          headline4: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff263238),
          ),
          headline6: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xff263238),
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: Color(0xff263238),
            fontWeight: FontWeight.w400,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            color: Color(0xff767171),
            fontWeight: FontWeight.w400,
          ),
          button: TextStyle(
            fontSize: 14,
            color: Color(0xffFFFFFF),
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
          ),
          caption: TextStyle(
            decoration: TextDecoration.underline,
            color: Color(0xff3A76CA),
            fontSize: 14,
          ),
        ),
      ),
      routes: {
        "/": (context) => const LoginPage(),
        "/exhibition": (context) => const QueueTVPage(),
      },
      initialRoute: "/",
    );
  }
}

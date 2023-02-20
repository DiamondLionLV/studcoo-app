import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studcoo/Pages/Login/auth_page.dart';
import 'package:studcoo/Pages/Login/login.dart';
import 'package:studcoo/Pages/Login/onboarding.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Main());
}

// class Main extends StatefulWidget {
//   const Main({Key? key}) : super(key: key);

//   @override
//   State<Main> createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Quicksand',
        unselectedWidgetColor: const Color(0xffb31c6e),
      ),
      home: AuthPage(),
    );
  }
}

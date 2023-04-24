import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:studcoo/Pages/home_screen.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]) // disables horizontal rotation
      .then((_) {
    runApp(const Main());
  });
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Quicksand',
        unselectedWidgetColor: const Color(0xffb31c6e),
      ),
      // routes: {
      //   '/': (context) => SplashScreen(),
      //   '/home': (context) => const AuthPage(),
      // },
      home: const HomeScreen(),
    );
  }
}

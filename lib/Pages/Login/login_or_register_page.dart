import 'package:flutter/material.dart';
import 'package:studcoo/Pages/Login/login.dart';
import 'package:studcoo/Pages/Login/register_page.dart';
import 'package:studcoo/Pages/variables.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page
  //bool showLoginPage = false;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (showLoginPage) {
    //   return LoginPage(
    //     onTap: togglePages,
    //   );
    // } else {
    //   return RegisterPage(
    //     onTap: togglePages,
    //   );
    // }
    return Scaffold();
  }
}

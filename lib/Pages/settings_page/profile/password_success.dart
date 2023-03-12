import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studcoo/Pages/Login/auth_page.dart';
import 'package:studcoo/Pages/Login/login_without_password.dart';
import 'package:studcoo/Pages/Login/onboarding.dart';
import 'package:studcoo/Pages/home.dart';
import 'package:studcoo/Pages/home_screen.dart';
import 'package:studcoo/Pages/profile_page.dart';
import 'package:studcoo/components/button-white.dart';
import 'package:studcoo/components/button.dart';
import 'package:studcoo/components/square_tile.dart';
import 'package:studcoo/components/textfield.dart';
import 'package:studcoo/main.dart';
import 'package:studcoo/services/auth_service.dart';

class PasswordChangedSuccessPage extends StatefulWidget {
  // final Function()? onTap;
  // const LoginPage({super.key, required this.onTap});
  const PasswordChangedSuccessPage({super.key});

  @override
  State<PasswordChangedSuccessPage> createState() =>
      _PasswordChangedSuccessPageState();
}

class _PasswordChangedSuccessPageState
    extends State<PasswordChangedSuccessPage> {
  void successUser(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 10),

                const Center(
                  child: Text(
                    "Congratulations!\nYour email was sucessfully\nchanged and confirmed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffb31c6e),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height / 8),

                Image(
                  image: const AssetImage(
                      "assets/illustrations/party_popper_illustration.png"),
                  width: MediaQuery.of(context).size.height / 4,
                  height: MediaQuery.of(context).size.height / 4,
                ),

                SizedBox(height: MediaQuery.of(context).size.height / 5),

                // sign in button
                MyButton(
                  onTap: () => successUser(context),
                  text: 'Return to profile page',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

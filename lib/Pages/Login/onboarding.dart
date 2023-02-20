import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:studcoo/Pages/Login/auth_page.dart';
import 'package:studcoo/Pages/Login/login.dart';
import 'package:studcoo/Pages/Login/login_or_register_page.dart';
import 'package:studcoo/Pages/Login/register_page.dart';
import 'package:studcoo/Pages/variables.dart';
import 'package:studcoo/components/button-boarding.dart';
import 'package:studcoo/components/button-white.dart';
import 'package:studcoo/components/button.dart';
import 'package:studcoo/components/square_tile.dart';
import 'package:studcoo/components/textfield.dart';
import 'package:studcoo/services/auth_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatefulWidget {
  //final Function()? onTap;
  //const OnboardingPage({super.key, required this.onTap});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  // sign in anonymously
  void signInAnon() async {
    final aUser = FirebaseAuth.instance.signInAnonymously();
  }

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 19, 89, 142),
          ),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        showErrorMessage('Wrong e-mail');
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        showErrorMessage("Wrong password");
      }
    }
  }

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff072f5f),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
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
                SizedBox(height: MediaQuery.of(context).size.width / 10),

                Image.asset(
                  'assets/studcoo_full-logo_colored.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 20,
                ),

                SizedBox(height: MediaQuery.of(context).size.width / 35),

                Text(
                  "Accelerate Your Learning",
                  style: TextStyle(
                    color: const Color(0xffb31c6e),
                    fontSize: MediaQuery.of(context).size.width / 21,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.width / 10),

                Lottie.asset(
                    'assets/learning_boy_animation_lottie_onboarding.json',
                    width: MediaQuery.of(context).size.width / 1,
                    height: MediaQuery.of(context).size.height / 3.5),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 7.5,
                ),

                // sign in button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xffc22466),
                          Color(0xffaa1578),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'Sign up free',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.width / 30,
                ),

                // google login button
                Platform.isAndroid
                    ? ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal:
                                  MediaQuery.of(context).size.width / 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          side: const BorderSide(
                            width: 3,
                            color: Color(0xffb31c6e),
                          ),
                        ),
                        onPressed: () => AuthService().signInWithGoogle(),
                        icon: Image.asset(
                          "lib/images/google.png",
                          height: 20,
                        ),
                        label: const Text(
                          'Continue with Google',
                          style: TextStyle(
                            color: Color(0xffb31c6e),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal:
                                  MediaQuery.of(context).size.width / 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          side: const BorderSide(
                            width: 3,
                            color: Color(0xffb31c6e),
                          ),
                        ),
                        onPressed: () => AuthService().signInWithGoogle(),
                        icon: Image.asset(
                          "lib/images/apple.png",
                          height: 20,
                        ),
                        label: const Text(
                          'Continue with Apple',
                          style: TextStyle(
                            color: Color(0xffb31c6e),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),

                SizedBox(
                  height: MediaQuery.of(context).size.width / 25,
                ),

                // anonymous sign in
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     MyButton(
                //       onTap: signInAnon,
                //       text: '   Login Anon   ',
                //     ),
                //   ],
                // ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: MediaQuery.of(context).size.width / 5.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xffb31c6e),
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

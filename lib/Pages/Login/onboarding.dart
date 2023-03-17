import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studcoo/Pages/Login/login.dart';
import 'package:studcoo/Pages/Login/register_page.dart';
import 'package:studcoo/services/auth_service.dart';

class OnboardingPage extends StatefulWidget {
  //final Function()? onTap;
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 12),

                Image.network(
                    'https://cdn.discordapp.com/attachments/1084961612970074212/1084961691114156032/apple_and_books_illustration.png',
                    width: MediaQuery.of(context).size.height / 4,
                    height: MediaQuery.of(context).size.height / 4),

                SizedBox(height: MediaQuery.of(context).size.width / 7),

                Image.network(
                  'https://cdn.discordapp.com/attachments/1084961612970074212/1085319306927153213/studcoo_full-logo_colored.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 20,
                ),

                SizedBox(height: MediaQuery.of(context).size.height / 30),

                Text(
                  "Scan, ask.\nLearn anything.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xffb31c6e),
                    fontSize: MediaQuery.of(context).size.width / 21,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
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
                // Platform.isAndroid
                //     ? ElevatedButton.icon(
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.white,
                //           padding: EdgeInsets.symmetric(
                //               vertical: 25,
                //               horizontal:
                //                   MediaQuery.of(context).size.width / 5),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(50),
                //           ),
                //           side: const BorderSide(
                //             width: 3,
                //             color: Color(0xffb31c6e),
                //           ),
                //         ),
                //         onPressed: () {
                //           AuthService().signInWithGoogle();
                //           // Navigator.push(
                //           //   context,
                //           //   MaterialPageRoute(
                //           //       builder: (context) => const AuthPage()),
                //           // );
                //         },
                //         icon: Image.asset(
                //           "lib/images/google.png",
                //           height: 20,
                //         ),
                //         label: const Text(
                //           'Continue with Google',
                //           style: TextStyle(
                //             color: Color(0xffb31c6e),
                //             fontWeight: FontWeight.bold,
                //             fontSize: 16,
                //           ),
                //         ),
                //       )
                //     : ElevatedButton.icon(
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.white,
                //           padding: EdgeInsets.symmetric(
                //               vertical: 25,
                //               horizontal:
                //                   MediaQuery.of(context).size.width / 5),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(50),
                //           ),
                //           side: const BorderSide(
                //             width: 3,
                //             color: Color(0xffb31c6e),
                //           ),
                //         ),
                //         onPressed: () {
                //           AuthService().signInWithApple();
                //           // Navigator.push(
                //           //   context,
                //           //   MaterialPageRoute(
                //           //       builder: (context) => const AuthPage()),
                //           // );
                //         },
                //         icon: Image.asset(
                //           "lib/images/apple.png",
                //           height: 20,
                //         ),
                //         label: const Text(
                //           'Continue with Apple',
                //           style: TextStyle(
                //             color: Color(0xffb31c6e),
                //             fontWeight: FontWeight.bold,
                //             fontSize: 16,
                //           ),
                //         ),
                //       ),

                SizedBox(
                  height: MediaQuery.of(context).size.width / 25,
                ),

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

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
                  height: MediaQuery.of(context).size.height / 9,
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
                    padding:
                        const EdgeInsets.all(25), // adjust percentage as needed
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width *
                            0.07), // adjust percentage as needed
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

                //google login button
                Platform.isAndroid
                    ? GestureDetector(
                        onTap: () => AuthService().signInWithGoogle(),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.07,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: 3,
                              color: const Color(0xffb31c6e),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/images/google.png",
                                width: MediaQuery.of(context).size.width / 25,
                                height: MediaQuery.of(context).size.width / 25,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  color: Color(0xffb31c6e),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => AuthService().signInWithApple(),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.07,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: 3,
                              color: const Color(0xffb31c6e),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/images/apple.png",
                                width: MediaQuery.of(context).size.width / 25,
                                height: MediaQuery.of(context).size.width / 25,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Sign in with Apple',
                                style: TextStyle(
                                  color: Color(0xffb31c6e),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

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

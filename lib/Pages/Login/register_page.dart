import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studcoo/Pages/Login/login.dart';
import 'package:studcoo/Pages/Login/privacypolicy.dart';
import 'package:studcoo/Pages/Login/termsofuse.dart';
import 'package:studcoo/components/button.dart';
import 'package:studcoo/components/square_tile.dart';
import 'package:studcoo/components/textfield.dart';
import 'package:studcoo/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  //final Function()? onTap;
  //const RegisterPage({super.key, required this.onTap});
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool? value = false;

  // sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xffb31c6e),
          ),
        );
      },
    );

    // try creating the user
    try {
      // register user in database
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // pop the loading circle
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        showErrorMessage('Nepareizs e-pasts');
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        showErrorMessage("Nepareiza parole");
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
      // Create account top heading with back button
      appBar: AppBar(
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xffb31c6e),
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Create account",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffb31c6e),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      // main page
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width / 10),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'E-mail',
                obscureText: false,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width / 50,
              ),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width / 50,
              ),

              // confirm password textfield
              // MyTextField(
              //   controller: confirmPasswordController,
              //   hintText: 'Repeat password',
              //   obscureText: true,
              // ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 90,
              ),

              // Email list consent
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Please send me news and offers from Studcoo",
                        style: TextStyle(
                          color: Color(0xffb31c6e),
                          fontSize: 13,
                        ),
                      ),
                      Checkbox(
                        value: this.value,
                        onChanged: (bool? value) {
                          setState(
                            () {
                              this.value = value;
                            },
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        activeColor: Color(0xffb31c6e),
                        checkColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TermsOfUsePage()),
                          );
                        },
                        child: const Text(
                          "Terms of Use",
                          style: TextStyle(
                            color: Color(0xffb31c6e),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicyPage()),
                          );
                        },
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: Color(0xffb31c6e),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),

              // info text about account creation
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "By tapping \"Create account\", you agree to\nStudcoo Terms of Use and Privacy Policy.",
                    style: TextStyle(
                      color: Color(0xffb31c6e),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),

              // sign in button
              MyButton(
                onTap: signUserUp,
                text: 'Create account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

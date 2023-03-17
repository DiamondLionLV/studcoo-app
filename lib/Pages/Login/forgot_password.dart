import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studcoo/Pages/Login/forgot_password_success.dart';
import 'package:studcoo/components/button.dart';
import 'package:studcoo/components/textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  // final Function()? onTap;
  // const ForgotPasswordPage({super.key, required this.onTap});
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // text editing controllers
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xffb31c6e), //change your color here
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Forgot password",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffb31c6e),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width / 10),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  obscureText: false,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.6,
                ),

                // sign in button
                MyButton(
                  onTap: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordSuccessPage()));
                  },
                  text: 'Send email',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

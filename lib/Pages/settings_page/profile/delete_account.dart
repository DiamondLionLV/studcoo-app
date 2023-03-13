import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studcoo/Pages/Login/auth_page.dart';
import 'package:studcoo/Pages/Login/onboarding.dart';
import 'package:studcoo/components/button.dart';
import 'package:studcoo/components/textfield.dart';

class DeleteAccountPage extends StatefulWidget {
  // final Function()? onTap;
  // const LoginPage({super.key, required this.onTap});
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void deleteUser(context) {
    FirebaseAuth.instance.currentUser!.delete();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnboardingPage()),
    );
  }

  // sign user in method
  void signUserIn() async {
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

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // pop the loading circle
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
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
      appBar: AppBar(
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xffb31c6e), //change your color here
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Delete account",
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width / 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: MediaQuery.of(context).size.width / 50),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Type in your password to confirm deletion.\nDeletion is irreversible.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xffb31c6e),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                ),

                // sign in button
                MyButton(
                  onTap: () => deleteUser(context),
                  text: 'Delete',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

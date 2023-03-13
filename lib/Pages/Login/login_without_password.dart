import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studcoo/Pages/Login/auth_page.dart';
import 'package:studcoo/components/button.dart';
import 'package:studcoo/components/textfield.dart';

class LoginWithoutPasswordPage extends StatefulWidget {
  // final Function()? onTap;
  // const LoginPage({super.key, required this.onTap});
  const LoginWithoutPasswordPage({super.key});

  @override
  State<LoginWithoutPasswordPage> createState() =>
      _LoginWithoutPasswordPageState();
}

class _LoginWithoutPasswordPageState extends State<LoginWithoutPasswordPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var acs = ActionCodeSettings(
      // URL you want to redirect back to. The domain (www.example.com) for this
      // URL must be whitelisted in the Firebase Console.
      url: 'https://studcoo.com',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.studcoo.studcooapp',
      androidPackageName: 'com.example.studcooapp',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');

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
      await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: emailController.text,
        actionCodeSettings: acs,
      );

      // Confirm the link is a sign-in with email link.
      // if (FirebaseAuth.instance.isSignInWithEmailLink(emailLink)) {
      //   try {
      //     // The client SDK will parse the code from the link for you.
      //     final userCredential = await FirebaseAuth.instance
      //         .signInWithEmailLink(
      //             email: emailController.text, emailLink: emailLink);

      //     // You can access the new user via userCredential.user.
      //     final emailAddress = userCredential.user?.email;

      //     print('Successfully signed in with email link!');
      //   } catch (error) {
      //     print('Error signing in with email link.');
      //   }
      // }

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
            "Login without password",
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

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  obscureText: false,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.71,
                ),

                // sign in button
                MyButton(
                  onTap: signUserIn,
                  text: 'Get link',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

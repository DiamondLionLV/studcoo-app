import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studcoo/Pages/Login/login.dart';
import 'package:studcoo/components/button.dart';
import 'package:studcoo/components/textfield.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final Uri privacypolicy = Uri.parse('https://studcoo.com/privacy-policy/');
  final Uri termsofuse = Uri.parse('https://studcoo.com/terms-of-use/');

  Future<void> _launchPP() async {
    if (!await launchUrl(privacypolicy)) {
      throw Exception('Could not launch $privacypolicy');
    }
  }

  Future<void> _launchTOU() async {
    if (!await launchUrl(termsofuse)) {
      throw Exception('Could not launch $termsofuse');
    }
  }

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your emails doesn't match"),
          ),
        );
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your password isn't correct"),
          ),
        );
      }
    }
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
              fontWeight: FontWeight.w700,
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
                        value: value,
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
                        activeColor: const Color(0xffb31c6e),
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
                        onTap: () => _launchTOU(),
                        child: const Text(
                          "Terms of Use",
                          style: TextStyle(
                            color: Color(0xffb31c6e),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _launchPP(),
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

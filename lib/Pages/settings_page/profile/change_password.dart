import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studcoo/Pages/settings_page/profile/password_success.dart';
import 'package:studcoo/components/button.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _repeatNewPasswordController = TextEditingController();

  String _errorMessage = '';

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          AuthCredential credential = EmailAuthProvider.credential(
              email: user.email!, password: _currentPasswordController.text);
          await user.reauthenticateWithCredential(credential);
          await user.updatePassword(_newPasswordController.text);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const PasswordChangedSuccessPage()));
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message ?? 'An error occurred';
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/back_icon.svg",
            width: 18,
            height: 18,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xffb31c6e),
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Change password",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          controller: _currentPasswordController,
                          cursorColor: const Color(0xffb31c6e),
                          style: const TextStyle(
                              color: Color(0xffb31c6e),
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                color: Color(0xfff4f4f6),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 228, 228, 229),
                              ),
                            ),
                            fillColor: const Color(0xfff4f4f6),
                            filled: true,
                            labelText: "Current password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xffb31c6e),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current password';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height / 50),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          controller: _newPasswordController,
                          cursorColor: const Color(0xffb31c6e),
                          style: const TextStyle(
                              color: Color(0xffb31c6e),
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                color: Color(0xfff4f4f6),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 228, 228, 229),
                              ),
                            ),
                            fillColor: const Color(0xfff4f4f6),
                            filled: true,
                            labelText: "New password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xffb31c6e),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please repeat your new password';
                            }
                            if (value != _newPasswordController.text) {
                              return "New password and repeat new password must match";
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height / 50),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          controller: _repeatNewPasswordController,
                          cursorColor: const Color(0xffb31c6e),
                          style: const TextStyle(
                              color: Color(0xffb31c6e),
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                color: Color(0xfff4f4f6),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 228, 228, 229),
                              ),
                            ),
                            fillColor: const Color(0xfff4f4f6),
                            filled: true,
                            labelText: "Repeat new password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xffb31c6e),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please repeat your new password';
                            }
                            if (value != _newPasswordController.text) {
                              return "New password and repeat new password must match";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                      ),
                      // sign in button
                      MyButton(
                        onTap: () => _changePassword(),
                        text: 'Change password',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

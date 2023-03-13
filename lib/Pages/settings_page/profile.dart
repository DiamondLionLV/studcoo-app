import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studcoo/Pages/Login/onboarding.dart';
import 'package:studcoo/Pages/settings_page/profile/change_email.dart';
import 'package:studcoo/Pages/settings_page/profile/change_password.dart';
import 'package:studcoo/Pages/settings_page/profile/delete_account.dart';

class ProfilePages extends StatelessWidget {
  ProfilePages({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut(context) {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnboardingPage()),
    );
  }

  // void deleteUser(context) {
  //   FirebaseAuth.instance.currentUser!.delete();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => OnboardingPage()),
  //   );
  // }
  void redirectUserDelete(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DeleteAccountPage()),
    );
  }

  void changeEmailRedirect(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChangeEmailPage()),
    );
  }

  void redirectUserChangePassword(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
    );
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
            "Profile",
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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 20),

          // Latvia hotline number
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/email_icon.svg",
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => changeEmailRedirect(context),
                          child: const Text(
                            "Change email",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffb31c6e),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height / 20),

          // Latvia hotline number
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/password_icon.svg",
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => redirectUserChangePassword(context),
                          child: const Text(
                            "Change password",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffb31c6e),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),

          // Latvia hotline number
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/delete_icon.svg",
                        width: 22,
                        height: 22,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => redirectUserDelete(context),
                      child: Row(
                        children: const [
                          Text(
                            "Delete account",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffb31c6e),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),

          // Latvia hotline number
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/log_out_icon.svg",
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => signUserOut(context),
                          child: const Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffb31c6e),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studcoo/Pages/Login/onboarding.dart';
import 'package:studcoo/Pages/settings_page/profile/change_email.dart';
import 'package:studcoo/Pages/settings_page/profile/change_password.dart';
import 'package:studcoo/Pages/settings_page/profile/delete_account.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final searchController = TextEditingController();

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
            "Language",
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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.width / 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: searchController,
              cursorColor: const Color(0xffb31c6e),
              style: const TextStyle(
                  color: Color(0xffb31c6e), fontWeight: FontWeight.w500),
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
                hintText: "Search language",
                hintStyle: const TextStyle(
                  color: Color(0xffb31c6e),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: const Color(0xffb31c6e),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.width / 10),

          // Latvia hotline number
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Image(
                        image: const AssetImage("assets/flags/globe.png"),
                        width: MediaQuery.of(context).size.width / 11,
                        height: MediaQuery.of(context).size.width / 11,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Global (English)",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

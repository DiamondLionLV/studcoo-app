import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home screen after 3 seconds
    Timer(Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xffc22466), Color(0xffaa1578)],
              ),
            ),
          ),
          const Center(
            child: Text(
              'studcoo',
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w600,
                fontFamily: 'Quicksand',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

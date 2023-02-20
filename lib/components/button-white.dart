import 'package:flutter/material.dart';

class MyButtonWhite extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButtonWhite({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 70),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Color(0xffb31c6e),
            width: 3,
          ),
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            color: Color(0xffb31c6e),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )),
      ),
    );
  }
}

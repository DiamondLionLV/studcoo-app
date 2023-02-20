import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintStyle: const TextStyle(
            color: Color(0xffb31c6e),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

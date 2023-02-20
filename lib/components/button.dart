import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffc22466),
              Color(0xffaa1578),
            ],
          ),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:studcoo/Pages/variables.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Results'),
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Column(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 201, 124, 209),
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 1.5,
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        const Text("Question:"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        Text(inputText),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        const Text("Answer:"),
                        Text(text),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

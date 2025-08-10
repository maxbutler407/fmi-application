import "package:flutter/material.dart";
import 'question2_widget.dart';

class Question1Page extends StatefulWidget {
  const Question1Page({super.key, required this.title});

  final String title;

  @override
  State<Question1Page> createState() => _Question1Page();
}

class _Question1Page extends State<Question1Page> {
  String question1 = "How do you currently feel?";

  List<String> answers = [
    "Extremely alert",
    "Very alert",
    "Alert",
    "Rather alert",
    "Neither alert nor sleepy",
    "Some signs of sleepiness",
    "Sleepy, but no difficulty remaining awake",
    "Sleepy, some effort to keep alert",
    "Extremely sleepy, fighting sleep",
  ];

  void handleAnswer(String answer) {
    print("Selected: $answer");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Question2Page(title: "Question 2")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question1,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            for (var answer in answers)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => handleAnswer(answer),
                  child: Text(answer),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

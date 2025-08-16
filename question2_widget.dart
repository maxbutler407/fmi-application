import "package:flutter/material.dart";
import "question_3.dart";

class Question2Page extends StatefulWidget {
  const Question2Page({super.key, required this.title});

  final String title;

  @override
  State<Question2Page> createState() => _Question2Page();
}

class _Question2Page extends State<Question2Page> {
  String question1 = "Rate your sleep in the last 24 hours";

  List<String> answers = [
    "Good",
    "Okay",
    "Poor",
    "Very Poor",
  ];

  void handleAnswer(String answer) {
    print("Selected: $answer");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Question3Page(title: "Question 3")));
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


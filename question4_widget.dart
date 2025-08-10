import "package:flutter/material.dart";

class Question4Page extends StatefulWidget {
  const Question4Page({super.key, required this.title});

  final String title;

  @override
  State<Question4Page> createState() => _Question4Page();
}

class _Question4Page extends State<Question4Page> {
  String question1 = "Are you experiencing any mental signs of fatigue?";

  List<String> answers = [
    "No",
    "Yes",
  ];

  void handleAnswer(String answer) {
    print("Selected: $answer");
    // TODO: navigate to next question
    // You can implement navigation logic here, for example:
    //Navigator.push(
    //context, MaterialPageRoute(builder: (context) => NextQuestionPage()));
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

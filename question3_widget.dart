import "package:flutter/material.dart";
import "question_4.dart";

class Question3Page extends StatefulWidget {
  const Question3Page({super.key, required this.title});

  final String title;

  @override
  State<Question3Page> createState() => _Question3Page();
}

class _Question3Page extends State<Question3Page> {
  String question1 = "Are you experiencing any physical signs of fatigue?";

  List<String> answers = [
    "No",
    "Yes",
  ];

  void handleAnswer(String answer) {
    print("Selected: $answer");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Question4Page(
                  title: "Question 4",
                  associateList: [], // Provide the appropriate value here
                )));
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

    );
  }
}


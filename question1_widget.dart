import "package:flutter/material.dart";
import "question_2.dart";
import "survey_page_state.dart";

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

  void handleAnswerAndNavigate(String answer, int index, Widget nextPage) {
    // ✅ Save answer to the central list in SurveyPage
    final surveyState = context.findAncestorStateOfType<SurveyPageState>();
    if (surveyState != null) {
      surveyState.handleAnswer(answer, index);
    }

    // ✅ Navigate safely to next page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
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
            for (var i = 0; i < answers.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => handleAnswerAndNavigate(
                    answers[i],
                    i,
                    const Question2Page(title: "Question 2"),
                  ),
                  child: Text(answers[i]),
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


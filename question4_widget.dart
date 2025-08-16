import 'package:flutter/material.dart';
import 'package:csv/csv.dart' as exportCSV;
import 'google_sheets_service.dart';

class Question4Page extends StatefulWidget {
  Question4Page({super.key, required this.title, required this.associateList});

  final String title;
  final List<Map<String, dynamic>> associateList; // Pass previous answers here

  @override
  State<Question4Page> createState() => _Question4PageState();
}

class _Question4PageState extends State<Question4Page> {
  String question1 = "Are you experiencing any mental signs of fatigue?";

  List<String> answers = [
    "No",
    "Yes",
  ];

  Future<void> handleAnswer(String answer) async {
    // Add this last answer to the list
    widget.associateList.add({
      "number": widget.associateList.length + 1,
      "answer": answer,
    });

    // Debug: log current associateList
    print("📋 Current associateList: ${widget.associateList}");

    // Export to CSV (optional local debug)
    exportToCsv(widget.associateList);

    // 👇 Send last answer to Google Sheets
    await sendAnswerToGoogleSheets(widget.associateList.length, answer);

    // Optional: Show a "thank you" message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Answer sent to Google Sheets!')),
    );
  }

  void exportToCsv(List<Map<String, dynamic>> associateList) {
    List<String> header = ['No.', 'Answer'];
    List<List<String>> rows = associateList
        .map((item) => [
              item["number"].toString(),
              item["answer"].toString(),
            ])
        .toList();

    String csv =
        const exportCSV.ListToCsvConverter().convert([header, ...rows]);

    print("📤 Exported CSV Preview:\n$csv"); // debug log
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


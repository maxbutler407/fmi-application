import "package:flutter/material.dart";
import 'package:csv/csv.dart' as exportCSV;



class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  SurveyPageState createState() => SurveyPageState();
}

class SurveyPageState extends State<SurveyPage> {
  final List<String> answers = [
    "Extremely sleepy, fighting sleep",
    "Sleepy, some effort to keep alert",
    "Sleepy, but no difficulty remaining awake",
    "Some signs of sleepiness",
    "Neither alert nor sleepy",
    "Rather alert",
    "Alert",
    "Very alert",
    "Extremely alert",
  ];

  // ✅ This will hold your answer data in the desired format
  List<Map<String, dynamic>> associateList = [];

  void handleAnswer(String answer, int index) {
    associateList.add({
      "number": index + 1,
      "answer": answer,
    });

    debugPrint(associateList.toString()); // Optional: to see it in console
  }

  // 📦 Export CSV using to_csv
  void exportToCsv() {
    // 1️⃣ Define header
    List<String> header = ['No.', 'Answer'];

    // 2️⃣ Map associateList into List<List<String>>
    List<List<String>> rows = associateList
        .map((item) => [
              item["number"].toString(),
              item["answer"].toString(),
            ])
        .toList();

    // 3️⃣ Export
    List<List<String>> csvData = [header, ...rows];
    String csv = exportCSV.ListToCsvConverter().convert(csvData);
    debugPrint(csv); // You can save or share this CSV string as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Survey')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Survey Page UI goes here')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: exportToCsv,
            child: const Text('Export Answers to CSV'),
          ),
        ],
      ),
    );
  }
}



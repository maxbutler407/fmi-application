import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future<void> sendAnswerToGoogleSheets(int number, String answer) async {
  const String url =
      "https://script.google.com/macros/s/AKfycbz_a5vbb09i877eTjCYcwwUb3MkuC5Lv2y1-yTJC3JiBaVHAmwEa-xDF9x3EqaNCAtg/exec";
  // Log the data before sending
  print("📤 Preparing to send data to Google Sheets:");
  print("number: $number");
  print("answer: $answer");
  print("endpoint: $url");

  final response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode({
      "number": number,
      "answer": answer,
    }),
  );
  if (response.statusCode == 200) {
    print("Data sent to Google Sheets");
  } else {
    print("Failed to send data: ${response.body}");
  }
}

import "package:flutter/material.dart";

class _SurveyPageState extends State<SurveyPage> {
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

  final _record = AudioRecorder();
  bool isRecording = false;

  // ✅ This will hold your answer data in the desired format
  List<Map<String, dynamic>> associateList = [];

  Future<String> getCsvPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/survey_data.csv";
  }

  Future<String> getAudioPath() async {
    final dir = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return "${dir.path}/voice_sample_$timestamp.m4a";
  }

  Future<void> saveToCsv(String answer, String audioPath) async {
    final path = await getCsvPath();
    final file = File(path);

    final exists = await file.exists();
    final sink = file.openWrite(mode: FileMode.append);

    if (!exists) {
      sink.writeln("timestamp,answer,voice_sample_path");
    }

    final row = [
      DateTime.now().toIso8601String(),
      '"$answer"',
      audioPath,
    ];

    sink.writeln(row.join(','));
    await sink.flush();
    await sink.close();

    debugPrint("Saved to CSV: $path");
  }

  Future<void> handleAnswer(String answer, int index) async {
    // Ask for mic permission
    if (!await Permission.microphone.request().isGranted) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Microphone permission denied")),
      );
      return;
    }

    final audioPath = await getAudioPath();

    // Start recording
    if (await _record.hasPermission()) {
      await _record.start(const RecordConfig(), path: audioPath);
      setState(() => isRecording = true);

      await Future.delayed(const Duration(seconds: 5));
      await _record.stop();
      setState(() => isRecording = false);

      await saveToCsv(answer, audioPath);

      // ✅ Add to associateList
      associateList
          .add({"number": index + 1, "answer": answer, "audioPath": audioPath});

      debugPrint("associateList: $associateList");

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saved answer and voice sample!")),
      );
    }
  }

  @override
  void dispose() {
    _record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sleep Survey")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "How do you currently feel?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < answers.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ElevatedButton(
                  onPressed: () => handleAnswer(answers[i], i),
                  child: Text(answers[i]),
                ),
              ),
            const SizedBox(height: 20),
            if (isRecording)
              const Center(
                child: Text(
                  "Recording...",
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlashcardScreen(),
    );
  }
}

class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  bool _showAnswer = false;

  final List<Map<String, String>> _flashcards = [
    {"question": "What is Flutter?", "answer": "Flutter is a UI toolkit by Google for building natively compiled applications."},
    {"question": "What is Dart?", "answer": "Dart is the programming language used by Flutter."},
    {"question": "What is a widget in Flutter?", "answer": "A widget is a building block of a Flutter app's UI."},
  ];

  int _currentIndex = 0;

  void _toggleAnswer() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _flashcards.length;
      _showAnswer = false;
    });
  }

  void _previousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % _flashcards.length;
      _showAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _showAnswer
                      ? _flashcards[_currentIndex]['answer']!
                      : _flashcards[_currentIndex]['question']!,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleAnswer,
              child: Text(_showAnswer ? 'Hide Answer' : 'Show Answer'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _previousCard,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _nextCard,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
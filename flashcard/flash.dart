import 'package:flutter/material.dart';

void main() {
  runApp(FlashCardApp()); // ✅ Main entry point
}

// Main App Class
class FlashCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlashCardScreen(), // ✅ Navigates to FlashCardScreen
      debugShowCheckedModeBanner: false, // ✅ Removes debug banner
    );
  }
}

// Stateful Widget for Flashcard Screen
class FlashCardScreen extends StatefulWidget {
  @override
  _FlashCardScreenState createState() => _FlashCardScreenState(); // ✅ State creator
}

// State Class
class _FlashCardScreenState extends State<FlashCardScreen> {
  // List of flashcards
  List<Map<String, String>> flashcards = [
    {'question': 'What is the capital of France?', 'answer': 'Paris'},
    {'question': 'What is 2 + 2?', 'answer': '4'},
    {'question': 'What is the largest planet?', 'answer': 'Jupiter'},
  ];

  int currentIndex = 0; // ✅ Track current card
  bool showAnswer = false; // ✅ Track whether to show answer or question

  // Move to next card
  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards.length; // Loop around
      showAnswer = false; // Reset to question
    });
  }

  // Flip card to show answer/question
  void flipCard() {
    setState(() {
      showAnswer = !showAnswer; // Toggle between question and answer
    });
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flash Cards'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: flipCard, // Tap to flip
          child: Card(
            margin: EdgeInsets.all(20),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: double.infinity,
              height: 300,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text(
                showAnswer
                    ? flashcards[currentIndex]['answer']! // Show answer
                    : flashcards[currentIndex]['question']!, // Show question
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: nextCard, // Press to go to next card
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

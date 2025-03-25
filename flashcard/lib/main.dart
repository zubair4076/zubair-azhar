import 'package:flutter/material.dart';

// Global list to persist the custom deck
List<Map<String, String>> customDeckGlobal = [];

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/deck': (context) => FlashcardScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flashcard Decks')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDeckButton(context, 'Flutter'),
            SizedBox(height: 20),
            _buildDeckButton(context, 'Dart'),
            SizedBox(height: 20),
            _buildDeckButton(context, 'Custom'),
          ],
        ),
      ),
    );
  }

  Widget _buildDeckButton(BuildContext context, String deckName) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/deck', arguments: deckName),
      child: Text('$deckName Deck'),
    );
  }
}

class FlashcardScreen extends StatefulWidget {
  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  bool _showAnswer = false;
  int _currentIndex = 0;
  int _score = 0;

  // Predefined decks
  final List<Map<String, String>> _flutterDeck = [
    {"question": "What is Flutter?", "answer": "A UI toolkit by Google"},
    {"question": "What is a widget?", "answer": "A building block of UI"},
  ];

  final List<Map<String, String>> _dartDeck = [
    {"question": "What is Dart?", "answer": "Programming language for Flutter"},
  ];

  late List<Map<String, String>> _currentDeck;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String deckName = ModalRoute.of(context)!.settings.arguments as String;
    _currentDeck = deckName == 'Flutter'
        ? _flutterDeck
        : deckName == 'Dart'
        ? _dartDeck
        : customDeckGlobal;
    _currentIndex = 0; // Reset index when deck changes
    _showAnswer = false;
  }

  void _toggleAnswer() {
    setState(() => _showAnswer = !_showAnswer);
  }

  void _nextCard() {
    if (_currentDeck.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % _currentDeck.length;
      _showAnswer = false;
    });
  }

  void _previousCard() {
    if (_currentDeck.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex - 1 + _currentDeck.length) % _currentDeck.length;
      _showAnswer = false;
    });
  }

  void _addFlashcard(String question, String answer) {
    setState(() {
      customDeckGlobal.add({"question": question, "answer": answer});
      _currentDeck = customDeckGlobal;
      _currentIndex = customDeckGlobal.length - 1;
    });
  }

  void _showAddDialog() {
    final questionController = TextEditingController();
    final answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Flashcard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: questionController, decoration: InputDecoration(labelText: 'Question')),
            TextField(controller: answerController, decoration: InputDecoration(labelText: 'Answer')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (questionController.text.isNotEmpty && answerController.text.isNotEmpty) {
                _addFlashcard(questionController.text, answerController.text);
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Deck'),
        actions: [IconButton(onPressed: _showAddDialog, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score: $_score', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            if (_currentDeck.isEmpty)
              Text('No flashcards. Add some!', style: TextStyle(color: Colors.grey))
            else
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    _showAnswer
                        ? _currentDeck[_currentIndex]['answer']!
                        : _currentDeck[_currentIndex]['question']!,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            SizedBox(height: 20),
            if (_currentDeck.isNotEmpty) ...[
              ElevatedButton(
                onPressed: _toggleAnswer,
                child: Text(_showAnswer ? 'Hide Answer' : 'Show Answer'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: _previousCard, child: Text('Previous')),
                  ElevatedButton(onPressed: _nextCard, child: Text('Next')),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () => setState(() => _score++), child: Text('Correct')),
                  ElevatedButton(onPressed: () => setState(() => _score--), child: Text('Incorrect')),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mid_project/widgets/custom_button.dart';

class TrueFalseScreen extends StatefulWidget {
  final int maxNumber;

  const TrueFalseScreen({super.key, required this.maxNumber});

  @override
  _TrueFalseScreenState createState() => _TrueFalseScreenState();
}

class _TrueFalseScreenState extends State<TrueFalseScreen> {
  int _score = 0;
  int _currentQuestion = 1;
  int _totalQuestions = 10;
  int _a = 0;
  int _b = 0;
  int _correctAnswer = 0;
  bool? _isCorrect;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    setState(() {
      _a = _getRandomNumber();
      _b = _getRandomNumber();
      _correctAnswer = _a * _b;
      // Randomly decide if we'll show correct or incorrect answer
      final random = Random();
      if (random.nextBool()) {
        _isCorrect = true;
      } else {
        _isCorrect = false;
      }
    });
  }

  int _getRandomNumber() {
    final random = Random();
    return random.nextInt(widget.maxNumber) + 1;
  }

  void _checkAnswer(bool userAnswer) {
    bool actualCorrectness = (_a * _b == _correctAnswer);
    bool isUserCorrect = (userAnswer == actualCorrectness);

    setState(() {
      if (isUserCorrect) {
        _score++;
      }
      _currentQuestion++;
    });

    if (_currentQuestion <= _totalQuestions) {
      _generateQuestion();
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Test Completed'),
        content: Text('Your score: $_score/$_totalQuestions'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('True/False Test'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _currentQuestion / _totalQuestions,
            ),
            const SizedBox(height: 20),
            Text(
              'Question $_currentQuestion/$_totalQuestions',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            Text(
              '$_a × $_b = $_correctAnswer',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Is this correct?',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  icon: Icons.check,
                  label: 'TRUE',
                  onPressed: () => _checkAnswer(true),
                  width: 150,
                ),
                CustomButton(
                  icon: Icons.close,
                  label: 'FALSE',
                  onPressed: () => _checkAnswer(false),
                  width: 150,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
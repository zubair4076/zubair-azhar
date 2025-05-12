// input_question_screen.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mid_project/widgets/custom_button.dart';

class InputQuestionScreen extends StatefulWidget {
  final int maxNumber;

  const InputQuestionScreen({super.key, required this.maxNumber});

  @override
  _InputQuestionScreenState createState() => _InputQuestionScreenState();
}

class _InputQuestionScreenState extends State<InputQuestionScreen> {
  int _score = 0;
  int _currentQuestion = 1;
  int _totalQuestions = 10;
  int _a = 0;
  int _b = 0;
  int _correctAnswer = 0;
  String _userAnswer = '';
  bool _showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    setState(() {
      _a = _getRandomNumber();
      _correctAnswer = _getRandomNumber();
      _b = _a * _correctAnswer;
      _userAnswer = '';
      _showCorrectAnswer = false;
    });
  }

  int _getRandomNumber() {
    final random = Random();
    return random.nextInt(widget.maxNumber) + 1;
  }

  void _checkAnswer() {
    if (_userAnswer.isEmpty) return;

    final userAnswer = int.tryParse(_userAnswer) ?? 0;
    final isCorrect = userAnswer == _correctAnswer;

    setState(() {
      if (isCorrect) {
        _score++;
      } else {
        _showCorrectAnswer = true;
      }
      _currentQuestion++;
    });

    if (_currentQuestion <= _totalQuestions) {
      Future.delayed(const Duration(seconds: 1), () {
        _generateQuestion();
      });
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

  void _addNumberToAnswer(String number) {
    setState(() {
      _userAnswer += number;
    });
  }

  void _clearAnswer() {
    setState(() {
      _userAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Answer'),
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
              '$_a × ? = $_b',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Enter your answer:',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              _userAnswer.isEmpty ? '?' : _userAnswer,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            if (_showCorrectAnswer)
              Text(
                'Correct answer: $_correctAnswer',
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
            const SizedBox(height: 20),

            // Number pad
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.all(20),
                children: [
                  for (int i = 1; i <= 9; i++)
                    _buildNumberButton(i.toString()),
                  _buildNumberButton('0'),
                  _buildClearButton(),
                  _buildSubmitButton(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: $_score',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: () => _addNumberToAnswer(number),
      child: Text(
        number,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: _clearAnswer,
      child: const Icon(Icons.backspace, size: 24),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: _checkAnswer,
      child: const Icon(Icons.check, size: 24),
    );
  }
}
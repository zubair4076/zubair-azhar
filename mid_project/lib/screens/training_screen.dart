import 'package:flutter/material.dart';
import 'package:mid_project/widgets/custom_button.dart';
import 'true_false_screen.dart';
import 'input_question_screen.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  int _minNumber = 1;
  int _maxNumber = 10;
  String _selectedGameType = 'Test';
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _minController.text = _minNumber.toString();
    _maxController.text = _maxNumber.toString();
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _updateMinNumber(String value) {
    final number = int.tryParse(value) ?? _minNumber;
    setState(() {
      _minNumber = number.clamp(0, 1000);
      if (_minNumber > _maxNumber) {
        _maxNumber = _minNumber;
        _maxController.text = _maxNumber.toString();
      }
    });
  }

  void _updateMaxNumber(String value) {
    final number = int.tryParse(value) ?? _maxNumber;
    setState(() {
      _maxNumber = number.clamp(_minNumber, 1000);
    });
  }

  void _startTraining() {
    if (_selectedGameType == 'True / False') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrueFalseScreen(maxNumber: _maxNumber),
        ),
      );
    } else if (_selectedGameType == 'Input') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InputQuestionScreen(maxNumber: _maxNumber),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selected game type is not implemented yet')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select difficulty'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What would you like to train?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Difficulty section
            const Text(
              'Difficulty (Max number = 1000)',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Number range selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _minController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _updateMinNumber,
                    onSubmitted: _updateMinNumber,
                  ),
                ),
                const Text('-'),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _maxController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _updateMaxNumber,
                    onSubmitted: _updateMaxNumber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Type of game section
            const Text(
              'Type of game',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Game type buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGameTypeButton('Test'),
                _buildGameTypeButton('True / False'),
                _buildGameTypeButton('Input'),
              ],
            ),
            const SizedBox(height: 40),

            // Start button
            Center(
              child: CustomButton(
                icon: Icons.play_arrow,
                label: 'START',
                onPressed: _startTraining,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameTypeButton(String type) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedGameType == type ? Colors.blue : null,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        setState(() {
          _selectedGameType = type;
        });
      },
      child: Text(
        type,
        style: TextStyle(
          color: _selectedGameType == type ? Colors.white : null,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mid_project/widgets//custom_button.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

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
                _buildNumberSelector('1'),
                const Text('-'),
                _buildNumberSelector('10'),
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
                onPressed: () {
                  // Start training
                },
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberSelector(String number) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildGameTypeButton(String type) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        // Select game type
      },
      child: Text(type),
    );
  }
}
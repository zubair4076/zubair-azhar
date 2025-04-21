import 'package:flutter/material.dart';
import 'package:mid_project/widgets/custom_button.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Statistics row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('Completed', '0'),
                _buildStatItem('Accuracy rate', '0%'),
              ],
            ),
            const SizedBox(height: 30),

            // Correct/Wrong indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildScoreIndicator('Correct', 0, Colors.green),
                _buildScoreIndicator('Wrong', 0, Colors.red),
              ],
            ),
            const SizedBox(height: 40),

            // Test complexity selection
            const Text(
              'Choose test complexity',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            // Complexity options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildComplexityOption('Easy'),
                _buildComplexityOption('Middle'),
                _buildComplexityOption('Hard'),
              ],
            ),
            const SizedBox(height: 40),

            // Start test button
            CustomButton(
              icon: Icons.play_arrow,
              label: 'START TEST',
              onPressed: () {
                // Start the test
              },
              width: 200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildScoreIndicator(String label, int count, Color color) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComplexityOption(String level) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        // Set test complexity
      },
      child: Text(level),
    );
  }
}
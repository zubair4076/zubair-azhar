import 'package:flutter/material.dart';
import  'learn_table_screen.dart';
import 'test_screen.dart';
import 'training_screen.dart';
import 'package:mid_project/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiplication Table'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First row with two buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    icon: Icons.extension,
                    label: 'Puzzles',
                    onPressed: () {
                      // Navigate to puzzles screen
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    icon: Icons.school,
                    label: 'Learn table',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LearnTableScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Second row with two buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    icon: Icons.fitness_center,
                    label: 'Training',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrainingScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    icon: Icons.quiz,
                    label: 'Start test',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // More exercises button
            CustomButton(
              icon: Icons.more_horiz,
              label: 'More exercises',
              onPressed: () {
                // Navigate to more exercises screen
              },
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
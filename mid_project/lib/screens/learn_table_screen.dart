import 'package:flutter/material.dart';
import 'package:mid_project/screens/multiplication_table_screen.dart';

class LearnTableScreen extends StatelessWidget {
  const LearnTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select item to learn'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First row of multiplication options
            _buildTableRow(['x1', 'x2', 'x3'], context),
            const SizedBox(height: 16),

            // Second row of multiplication options
            _buildTableRow(['x4', 'x5', 'x6'], context),
            const SizedBox(height: 16),

            // Google Play and Puzzle buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Google Play'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('SGREW PUZZLE'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Third row of multiplication options
            _buildTableRow(['x7', 'x8', 'x9'], context),
            const SizedBox(height: 16),

            // Fourth row of multiplication options
            _buildTableRow(['x10', 'x11', 'x12'], context),
            const SizedBox(height: 16),

            // Fifth row of multiplication options
            _buildTableRow(['x13', 'x14', 'x15'], context),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(List<String> tables, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tables.map((table) => _buildTableOption(table, context)).toList(),
    );
  }

  // Update in learn_table_screen.dart
  Widget _buildTableOption(String table, BuildContext context) {
    final tableNumber = int.parse(table.substring(1)); // Extract number from "x1", "x2", etc.

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(80, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiplicationTableScreen(tableNumber: tableNumber),
          ),
        );
      },
      child: Text(
        table,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
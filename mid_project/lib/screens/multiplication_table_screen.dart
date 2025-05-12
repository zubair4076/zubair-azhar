// Create a new file: multiplication_table_screen.dart
import 'package:flutter/material.dart';

class MultiplicationTableScreen extends StatelessWidget {
  final int tableNumber;

  const MultiplicationTableScreen({super.key, required this.tableNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiplication Table of $tableNumber'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 15, // Showing up to 15 times
          itemBuilder: (context, index) {
            final multiplier = index + 1;
            return Card(
              child: ListTile(
                title: Text('$tableNumber × $multiplier = ${tableNumber * multiplier}'),
                tileColor: index % 2 == 0 ? Colors.grey[100] : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
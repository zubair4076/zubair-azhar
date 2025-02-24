import 'dart:math';

class LuckyDraw {
  List<String> participants;

  // Constructor to initialize participants
  LuckyDraw(this.participants);

  // Method to draw 'count' winners (default is 4)
  List<String> drawWinners([int count = 4]) {
    if (participants.length < count) {
      throw Exception("Not enough participants for the draw!");
    }

    // Create a copy of participants for shuffling
    List<String> temp = List.from(participants);

    // Shuffle the list using Dart's Random
    temp.shuffle(Random());

    // Return the first 'count' participants as winners
    return temp.sublist(0, count);
  }
}

void main() {
  // List of participants
  List<String> participants = [
    'Alice', 'Bob', 'Charlie', 'David', 'Emma', 'Frank', 'Grace', 'Henry'
  ];

  // Create an instance of LuckyDraw
  LuckyDraw luckyDraw = LuckyDraw(participants);

  try {
    // Draw four winners
    List<String> winners = luckyDraw.drawWinners();

    // Display winners
    print('🎉 Congratulations to the committee members:');
    for (var winner in winners) {
      print('🏆 $winner');
    }
  } catch (e) {
    print('❗ Error: $e');
  }
}

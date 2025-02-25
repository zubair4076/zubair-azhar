import 'dart:math';

class Member {
  String name;
  double balance;
  bool hasReceived;

  Member(this.name) : balance = 0, hasReceived = false;

  void deposit(double amount) {
    balance += amount;
  }
}

class Committee {
  List<Member> members = [];
  double totalBalance = 0;
  int totalDuration;
  int stepDuration;
  Random random = Random();

  Committee(this.totalDuration, this.stepDuration);

  void addMember(String name) {
    members.add(Member(name));
  }

  void depositForAll(double amount) {
    for (var member in members) {
      member.deposit(amount);
      totalBalance += amount;
    }
  }

  void startCommittee() {
    int completedDuration = 0;

    while (completedDuration < totalDuration) {
      depositForAll(10); // Example deposit per step
      completedDuration += stepDuration;

      var eligible = members.where((m) => !m.hasReceived).toList();
      if (eligible.isEmpty) break;

      var winner = eligible[random.nextInt(eligible.length)];
      winner.hasReceived = true;
      winner.balance += totalBalance;

      print('Winner: ${winner.name} received \$${totalBalance.toStringAsFixed(2)}');
      totalBalance = 0;
    }

    print('Committee completed.');
  }

  void displayStatus() {
    for (var member in members) {
      print('Member: ${member.name}, Balance: \$${member.balance.toStringAsFixed(2)}, Received: ${member.hasReceived ? "Yes" : "No"}');
    }
    print('Total Committee Balance: \$${totalBalance.toStringAsFixed(2)}');
  }
}

void main() {
  var committee = Committee(4000, 1000);

  committee.addMember('Alice');
  committee.addMember('Bob');
  committee.addMember('Charlie');
  committee.addMember('Diana');

  committee.startCommittee();
  committee.displayStatus();
}

#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>
#include <ctime>
#include <algorithm>

class Member {
public:
    std::string name;
    double balance;
    bool hasReceived;

    Member(std::string n) : name(n), balance(0), hasReceived(false) {}

    void deposit(double amount) {
        balance += amount;
    }
};

class Committee {
private:
    std::vector<Member> members;
    double totalBalance;
    int totalDuration;
    int stepDuration;

public:
    Committee(int totalDur, int stepDur) : totalBalance(0), totalDuration(totalDur), stepDuration(stepDur) {
        std::srand(std::time(0));
    }

    void addMember(const std::string& name) {
        members.emplace_back(name);
    }

    void depositForAll(double amount) {
        for (auto& member : members) {
            member.deposit(amount);
            totalBalance += amount;
        }
    }

    void startCommittee() {
        int completedDuration = 0;

        while (completedDuration < totalDuration) {
            depositForAll(10); // Example deposit per step
            completedDuration += stepDuration;
            
            // Select random member who hasn't received
            std::vector<int> eligible;
            for (size_t i = 0; i < members.size(); ++i) {
                if (!members[i].hasReceived) eligible.push_back(i);
            }

            if (eligible.empty()) break;

            int winnerIndex = eligible[std::rand() % eligible.size()];
            members[winnerIndex].hasReceived = true;
            members[winnerIndex].balance += totalBalance;

            std::cout << "Winner: " << members[winnerIndex].name << " received " << totalBalance << "\n";
            totalBalance = 0;
        }

        std::cout << "Committee completed.\n";
    }

    void displayStatus() const {
        for (const auto& member : members) {
            std::cout << "Member: " << member.name << ", Balance: " << member.balance << ", Received: " << (member.hasReceived ? "Yes" : "No") << "\n";
        }
        std::cout << "Total Committee Balance: " << totalBalance << "\n";
    }
};

int main() {
    Committee committee(4000, 1000);

    committee.addMember("Alice");
    committee.addMember("Bob");
    committee.addMember("Charlie");
    committee.addMember("Diana");

    committee.startCommittee();
    committee.displayStatus();

    return 0;
}

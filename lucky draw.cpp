#include <iostream>
#include <vector>
#include <string>
#include <algorithm>  // for std::shuffle
#include <random>     // for std::random_device and std::mt19937
#include <stdexcept>  // for std::runtime_error

class LuckyDraw {
private:
    std::vector<std::string> participants;
    
public:
    // Constructor that initializes the list of participants
    LuckyDraw(const std::vector<std::string>& participants) : participants(participants) {}

    // Method to draw 'count' winners (default is 4)
    std::vector<std::string> drawWinners(int count = 4) {
        if (participants.size() < static_cast<size_t>(count)) {
            throw std::runtime_error("Not enough participants for the draw!");
        }
        
        // Create a temporary copy of participants for shuffling
        std::vector<std::string> temp = participants;

        // Set up random number generator
        std::random_device rd;
        std::mt19937 gen(rd());

        // Shuffle the list randomly
        std::shuffle(temp.begin(), temp.end(), gen);

        // Select the first 'count' elements as winners
        std::vector<std::string> winners(temp.begin(), temp.begin() + count);
        return winners;
    }
};

int main() {
    // List of participants
    std::vector<std::string> participants = {
        "Alice", "Bob", "Charlie", "David", "Emma", "Frank", "Grace", "Henry"
    };

    // Create an instance of LuckyDraw with the participants list
    LuckyDraw luckyDraw(participants);

    try {
        // Draw four winners
        std::vector<std::string> winners = luckyDraw.drawWinners();

        // Display the winners
        std::cout << "Congratulations to the committee members:" << std::endl;
        for (const auto &winner : winners) {
            std::cout << winner << std::endl;
        }
    } catch (const std::exception &e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }
    
    return 0;
}
import 'package:get/get.dart';
import 'package:tic_tac_toe/components/enums/enum.dart';

// class RobotPlayController extends GetxController {
//   var board = List.filled(9, '').obs; // 3x3 board
//   var currentPlayer = 'X'.obs;
//   var gameStatus = ''.obs;

//   // Make move
//   void makeMove(int index) {
//     if (board[index] == '' && gameStatus.value == '') {
//       board[index] = currentPlayer.value;
//       if (checkWin()) {
//         gameStatus.value = '${currentPlayer.value} Wins!';
//       } else if (board.contains('')) {
//         currentPlayer.value = 'O'; // Robot's turn
//         robotMove(); // Call the minimax AI for the robot's move
//       } else {
//         gameStatus.value = 'Draw';
//       }
//     }
//   }

//   // Robot's move using Minimax Algorithm
//   void robotMove() {
//     if (gameStatus.value != '') return; // Stop if the game is already over

//     int bestMove = findBestMove();
//     board[bestMove] = 'O';
//     if (checkWin()) {
//       gameStatus.value = 'Robot Wins!';
//     } else if (!board.contains('')) {
//       gameStatus.value = 'Draw';
//     } else {
//       currentPlayer.value = 'X'; // Player's turn
//     }
//   }

//   // Minimax Algorithm to find the best move for the robot
//   int findBestMove() {
//     int bestScore = -1000;
//     int move = -1;

//     for (int i = 0; i < board.length; i++) {
//       if (board[i] == '') {
//         board[i] = 'O'; // Simulate robot's move
//         int score = minimax(0, false); // Call minimax for player's turn
//         board[i] = ''; // Undo move
//         if (score > bestScore) {
//           bestScore = score;
//           move = i;
//         }
//       }
//     }
//     return move;
//   }

//   // Minimax Algorithm to calculate the best move
//   int minimax(int depth, bool isMaximizing) {
//     if (checkWinWithPlayer('O')) return 10; // Robot wins
//     if (checkWinWithPlayer('X')) return -10; // Player wins
//     if (!board.contains('')) return 0; // Draw

//     if (isMaximizing) {
//       int bestScore = -1000;
//       for (int i = 0; i < board.length; i++) {
//         if (board[i] == '') {
//           board[i] = 'O'; // Robot's move
//           int score = minimax(depth + 1, false);
//           board[i] = ''; // Undo move
//           bestScore = max(score, bestScore);
//         }
//       }
//       return bestScore;
//     } else {
//       int bestScore = 1000;
//       for (int i = 0; i < board.length; i++) {
//         if (board[i] == '') {
//           board[i] = 'X'; // Player's move
//           int score = minimax(depth + 1, true);
//           board[i] = ''; // Undo move
//           bestScore = min(score, bestScore);
//         }
//       }
//       return bestScore;
//     }
//   }

//   // Check win for a specific player (used in minimax)
//   bool checkWinWithPlayer(String player) {
//     List<List<int>> winConditions = [
//       [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
//       [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
//       [0, 4, 8], [2, 4, 6] // Diagonals
//     ];

//     for (var condition in winConditions) {
//       if (board[condition[0]] == player &&
//           board[condition[1]] == player &&
//           board[condition[2]] == player) {
//         return true;
//       }
//     }
//     return false;
//   }

//   // Regular check win for current player
//   bool checkWin() {
//     return checkWinWithPlayer(currentPlayer.value);
//   }

//   // Reset the game
//   void resetGame() {
//     board.value = List.filled(9, '');
//     gameStatus.value = '';
//     currentPlayer.value = 'X'; // Player always starts
//   }

//   // Helper functions for the minimax algorithm
//   int max(int a, int b) => a > b ? a : b;
//   int min(int a, int b) => a < b ? a : b;
// }

class RobotPlayController extends GetxController {
  var board = List.filled(9, Player.none).obs; // 3x3 board initialized as empty
  var currentPlayer = Player.X.obs; // 'X' always starts
  var gameStatus = GameStatus.ongoing.obs;

  // Make a move
  void makeMove(int index) {
    if (board[index] == Player.none && gameStatus.value == GameStatus.ongoing) {
      board[index] = currentPlayer.value;
      if (checkWin()) {
        gameStatus.value = currentPlayer.value == Player.X
            ? GameStatus.win
            : GameStatus.failed;
      } else if (board.contains(Player.none)) {
        currentPlayer.value = Player.O; // Robot's turn
        robotMove();
      } else {
        gameStatus.value = GameStatus.draw;
      }
    }
  }

  // Robot's move using Minimax Algorithm
  void robotMove() {
    if (gameStatus.value != GameStatus.ongoing) {
      return; // Stop if the game is over
    }
    int bestMove = findBestMove();
    board[bestMove] = Player.O;
    if (checkWin()) {
      gameStatus.value = GameStatus.failed;
    } else if (!board.contains(Player.none)) {
      gameStatus.value = GameStatus.draw;
    } else {
      currentPlayer.value = Player.X; // Player's turn
    }
  }

  // Minimax Algorithm to find the best move for the robot
  int findBestMove() {
    int bestScore = -1000;
    int move = -1;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == Player.none) {
        board[i] = Player.O; // Simulate robot's move
        int score = minimax(0, false); // Call minimax for player's turn
        board[i] = Player.none; // Undo move
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    return move;
  }

  // Minimax Algorithm
  int minimax(int depth, bool isMaximizing) {
    if (checkWinWithPlayer(Player.O)) return 10; // Robot wins
    if (checkWinWithPlayer(Player.X)) return -10; // Player wins
    if (!board.contains(Player.none)) return 0; // Draw

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == Player.none) {
          board[i] = Player.O; // Robot's move
          int score = minimax(depth + 1, false);
          board[i] = Player.none; // Undo move
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == Player.none) {
          board[i] = Player.X; // Player's move
          int score = minimax(depth + 1, true);
          board[i] = Player.none; // Undo move
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  // Check win for a specific player
  bool checkWinWithPlayer(Player player) {
    List<List<int>> winConditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] == player &&
          board[condition[1]] == player &&
          board[condition[2]] == player) {
        return true;
      }
    }
    return false;
  }

  // Regular check win for current player
  bool checkWin() {
    return checkWinWithPlayer(currentPlayer.value);
  }

  // Reset the game
  void resetGame() {
    board.value = List.filled(9, Player.none);
    gameStatus.value = GameStatus.ongoing;
    currentPlayer.value = Player.X; // Player always starts
  }

  // Helper functions for the minimax algorithm
  int max(int a, int b) => a > b ? a : b;
  int min(int a, int b) => a < b ? a : b;
}

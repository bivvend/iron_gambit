import 'package:iron_gambit/classes/board_state.dart';
import 'package:iron_gambit/controllers/game_controller.dart';
import 'package:iron_gambit/defines.dart';
import 'package:get/get.dart';

import '../classes/piece.dart';

class BoardController extends GetxController {
  // Controller to store board positions
  DisplayBoardState displayBoardState = DisplayBoardState(boardSize);
  int count = 0;
  GameController gC = Get.find();
  BoardController();

  /// Moves a piece from the source square to the destination square, updating its position.
  /// This simple implementation does not perform move validation
  void movePiece(int fromRow, int fromCol, int toRow, int toCol) {
    Piece? piece = displayBoardState.pieceAt(fromRow, fromCol);
    if (piece != null) {
      // Move the piece to the new square.
      displayBoardState.pieces[toRow][toCol] =
          Piece(type: piece.type, color: piece.color, row: toRow, col: toCol);
      displayBoardState.pieces[fromRow][fromCol] = null;
    }
  }

  void markCanMoveToRange(List<(int, int)> squares) {
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        displayBoardState.canMoveTo[i][j] = false;
      }
    }

    squares.forEach((s) {
      if (_checkInBounds(s.$1, s.$2)) {
        if (displayBoardState.pieceAt(s.$1, s.$2) == null) {
          displayBoardState.canMoveTo[s.$1][s.$2] = true;
        }
      }
    });
    displayBoardState.canMoveTo.refresh();
  }

  void markCanAttackRange(List<(int, int)> squares) {
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        displayBoardState.canAttack[i][j] = false;
      }
    }

    squares.forEach((s) {
      if (_checkInBounds(s.$1, s.$2)) {
        displayBoardState.canAttack[s.$1][s.$2] = true;
      }
    });
    displayBoardState.canAttack.refresh();
  }

  void markCanBuildRange(List<(int, int)> squares) {
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        displayBoardState.canBuildAt[i][j] = false;
      }
    }
    squares.forEach((s) {
      if (_checkInBounds(s.$1, s.$2)) {
        displayBoardState.canBuildAt[s.$1][s.$2] = true;
      }
    });
    displayBoardState.canBuildAt.refresh();
  }

  void deselectAll() {
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        displayBoardState.canBuildAt[i][j] = false;
        displayBoardState.canBuildAt.refresh();
        displayBoardState.canMoveTo[i][j] = false;
        displayBoardState.canMoveTo.refresh();
        displayBoardState.canAttack[i][j] = false;
        displayBoardState.canAttack.refresh();
        displayBoardState.selected[i][j] = false;
        displayBoardState.selected.refresh();
      }
    }
  }

  void selectSquare(int row, int col) {
    //Check the square is valid, contains a piece from your team.
    if (_checkInBounds(row, col)) {
      if (displayBoardState.pieces[row][col] != null) {
        if (displayBoardState.pieces[row][col]?.color == gC.turnState.value) {
          for (int i = 0; i < boardSize; i++) {
            for (int j = 0; j < boardSize; j++) {
              displayBoardState.selected[i][j] = false;
            }
          }

          displayBoardState.selected[row][col] = true;

          //Draw movement options
          //Get the piece at the new square
          List<(int, int)> movesList = [];
          var piece = displayBoardState.pieceAt(row, col);

          piece?.moves.forEach((m) {
            var row2 = m.dx + piece.row;
            var col2 = m.dy + piece.col;
            movesList.add((row2, col2));
          });
          markCanMoveToRange(movesList);
          gC.selectPiece(piece!.type, piece!.actions, row, col);
        }
      }
    }
    displayBoardState.selected.refresh();
  }

  actionAtSquare(int row, int col) {
    //Check the square is valid, contains a piece from your team.
    if (_checkInBounds(row, col)) {}
  }

  bool _checkInBounds(int col, int row) {
    return (row >= 0 && row < boardSize && col >= 0 && col < boardSize);
  }
}

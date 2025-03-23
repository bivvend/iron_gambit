import 'package:iron_gambit/classes/piece.dart';
import 'package:iron_gambit/defines.dart';
import 'package:get/get.dart';

class BoardState {
  final int boardSize;
  // A 2D list representing the board. A null value indicates an empty square.
  late List<List<Piece?>> board;

  var turnState = PieceColor.white;

  BoardState(this.boardSize) {
    board = List.generate(
      boardSize,
      (_) => List<Piece?>.filled(boardSize, null, growable: false),
      growable: false,
    );
    resetBoard();
  }

  /// Sets up the board with the standard chess starting position.
  void resetBoard() {
    // Clear the board first.
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        board[i][j] = null;
      }
    }

    // Initialize Black pieces (top of the board, rows 0 and 1)
    //board[0][0] = ChessPiece(type: ChessPieceType.rook, color: ChessPieceColor.black, row: 0, col: 0);
  }

  /// Returns the piece at the given row and column. Returns null if the square is empty
  /// or if the indices are out of bounds.
  Piece? pieceAt(int row, int col) {
    if (row < 0 || row >= boardSize || col < 0 || col >= boardSize) {
      return null;
    }
    return board[row][col];
  }

  /// Moves a piece from the source square to the destination square, updating its position.
  /// This simple implementation does not perform move validation
  void movePiece(int fromRow, int fromCol, int toRow, int toCol) {
    Piece? piece = pieceAt(fromRow, fromCol);
    if (piece != null) {
      // Move the piece to the new square.
      board[toRow][toCol] =
          Piece(type: piece.type, color: piece.color, row: toRow, col: toCol);
      board[fromRow][fromCol] = null;
    }
  }
}

class DisplayBoardState {
  final int boardSize;
  // A 2D list representing the board. A null value indicates an empty square.
  late RxList<RxList<Piece?>> pieces;
  late RxList<RxList<bool>> selected;
  late RxList<RxList<bool>> canMoveTo;
  late RxList<RxList<bool>> canAttack;
  late RxList<RxList<bool>> canBuildAt;

  DisplayBoardState(this.boardSize) {
    pieces = RxList.generate(
      boardSize,
      (_) => RxList<Piece?>.filled(boardSize, null, growable: false),
      growable: false,
    );
    selected = RxList.generate(
      boardSize,
      (_) => RxList<bool>.filled(boardSize, false, growable: false),
      growable: false,
    );
    canMoveTo = RxList.generate(
      boardSize,
      (_) => RxList<bool>.filled(boardSize, false, growable: false),
      growable: false,
    );
    canAttack = RxList.generate(
      boardSize,
      (_) => RxList<bool>.filled(boardSize, false, growable: false),
      growable: false,
    );
    canBuildAt = RxList.generate(
      boardSize,
      (_) => RxList<bool>.filled(boardSize, false, growable: false),
      growable: false,
    );
    resetBoard();
  }

  /// Sets up the board with the standard starting positions.
  void resetBoard() {
    // Clear the board first.
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        pieces[i][j] = null;
      }
    }

    pieces[6][3] =
        Piece(type: PieceType.worker, color: PieceColor.white, row: 6, col: 3);
    pieces[6][5] =
        Piece(type: PieceType.worker, color: PieceColor.white, row: 6, col: 5);
    pieces[7][3] = Piece(
        type: PieceType.generator, color: PieceColor.white, row: 7, col: 3);
    pieces[7][5] = Piece(
        type: PieceType.generator, color: PieceColor.white, row: 7, col: 5);

    pieces[2][3] =
        Piece(type: PieceType.worker, color: PieceColor.black, row: 2, col: 3);
    pieces[2][5] =
        Piece(type: PieceType.worker, color: PieceColor.black, row: 2, col: 5);
    pieces[1][3] = Piece(
        type: PieceType.generator, color: PieceColor.black, row: 1, col: 3);
    pieces[1][5] = Piece(
        type: PieceType.generator, color: PieceColor.black, row: 1, col: 5);

    pieces.refresh();
  }

  /// Returns the piece at the given row and column. Returns null if the square is empty
  /// or if the indices are out of bounds.
  Piece? pieceAt(int row, int col) {
    if (row < 0 || row >= boardSize || col < 0 || col >= boardSize) {
      return null;
    }
    return pieces[row][col];
  }
}

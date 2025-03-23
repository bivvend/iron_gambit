import 'package:iron_gambit/defines.dart';
import 'package:get/get.dart';

/// Represents a move offset (delta in columns and rows).
class MoveDefinition {
  final int dx; // Change in column
  final int dy; // Change in row

  const MoveDefinition(
    this.dx,
    this.dy,
  );

  @override
  String toString() => '($dx, $dy)';
}

/// Piece is the lower level data version.  These are manipulated

class Piece {
  final PieceType type;
  final PieceColor color;
  int row;
  int col;
  List<MoveDefinition> moves = [];
  int energyCost = 0;
  int energyGeneration = 0;

  Piece({
    required this.type,
    required this.color,
    required this.row,
    required this.col,
  }) {
    if (type == PieceType.worker ||
        type == PieceType.tank ||
        type == PieceType.mech) {
      moves.add(const MoveDefinition(1, 1));
      moves.add(const MoveDefinition(1, 0));
      moves.add(const MoveDefinition(1, -1));
      moves.add(const MoveDefinition(-1, 1));
      moves.add(const MoveDefinition(-1, 0));
      moves.add(const MoveDefinition(-1, -1));
      moves.add(const MoveDefinition(0, 1));
      moves.add(const MoveDefinition(0, -1));
    }

    if (type == PieceType.worker) {
      energyCost = energyCostWorker;
    } else if (type == PieceType.tank) {
      energyCost = energyCostTank;
    } else if (type == PieceType.gun) {
      energyCost = energyCostGun;
    } else if (type == PieceType.mech) {
      energyCost = energyCostMech;
    }

    if (type == PieceType.generator) {
      energyGeneration = energyGenerationGenerator;
    }
  }

  /// Returns the chess board square in algebraic notation.
  /// Example: row 0, col 0 corresponds to a8.
  String get position {
    return '[$row,$col]';
  }

  @override
  String toString() {
    return '${color.name} ${type.name} at $position';
  }
}

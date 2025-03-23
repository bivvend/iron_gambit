import 'package:flutter/material.dart';
import 'package:iron_gambit/controllers/board_controller.dart';
import 'package:iron_gambit/defines.dart';
import 'package:get/get.dart';

class BoardWidget extends StatelessWidget {
  final int boardSize; // Standard chess board size

  BoardWidget(this.boardSize, {super.key});

  final BoardController bC = Get.find();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0, // Ensures the board is square
        child: Stack(
          children: [
            const Positioned.fill(
              child: Image(
                image: AssetImage('assets/tiles.png'),
                fit: BoxFit.cover,
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: boardSize,
              ),
              itemCount: boardSize * boardSize,
              itemBuilder: (context, index) {
                int row = index ~/ boardSize;
                int col = index % boardSize;
                return Obx(() {
                  return GestureDetector(
                    onTap: () {
                      bC.selectSquare(row, col);
                    },
                    onSecondaryTap: () {
                      bC.actionAtSquare(row, col);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            //color: isDarkSquare ? Colors.brown : Colors.white,
                            color: Colors.transparent,
                            border: _getBorderColour(row, col)),
                        child: Obx(() {
                          return bC.displayBoardState.pieces[row][col] == null
                              ? Container()
                              : Container(
                                  margin: const EdgeInsets.all(3),
                                  child: Image(
                                    image: _getImageForSquare(row, col),
                                    fit: BoxFit.contain,
                                  ),
                                );
                        })),
                  );
                });
              },
            ),
          ],
        ));
  }

  Border? _getBorderColour(int row, int col) {
    double borderWidth = 3;
    if (bC.displayBoardState.selected[row][col]) {
      return Border.all(color: Colors.black, width: borderWidth);
    } else if (bC.displayBoardState.canAttack[row][col]) {
      return Border.all(color: Colors.red, width: borderWidth);
    } else if (bC.displayBoardState.canBuildAt[row][col] &&
        bC.displayBoardState.canMoveTo[row][col]) {
      return Border.all(color: Colors.yellow, width: borderWidth);
    } else if (!bC.displayBoardState.canBuildAt[row][col] &&
        bC.displayBoardState.canMoveTo[row][col]) {
      return Border.all(color: Colors.green, width: borderWidth);
    } else if (bC.displayBoardState.canBuildAt[row][col]) {
      return Border.all(color: Colors.blue, width: borderWidth);
    }
    return Border.all(color: Colors.transparent, width: borderWidth);
  }

  AssetImage _getImageForSquare(int row, int col) {
    String colour = "";
    if (bC.displayBoardState.pieces[row][col]?.color == PieceColor.white) {
      colour = "_white";
    }
    if (bC.displayBoardState.pieces[row][col]?.type == PieceType.gun) {
      return AssetImage('assets/gun$colour.png');
    }
    if (bC.displayBoardState.pieces[row][col]?.type == PieceType.worker) {
      return AssetImage('assets/worker$colour.png');
    }
    if (bC.displayBoardState.pieces[row][col]?.type == PieceType.mech) {
      return AssetImage('assets/mech$colour.png');
    }
    if (bC.displayBoardState.pieces[row][col]?.type == PieceType.generator) {
      return AssetImage('assets/generator$colour.png');
    }
    if (bC.displayBoardState.pieces[row][col]?.type == PieceType.tank) {
      return AssetImage('assets/tank$colour.png');
    } else {
      return AssetImage('assets/worker$colour.png');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:iron_gambit/controllers/board_controller.dart';
import 'package:iron_gambit/controllers/game_controller.dart';
import 'package:iron_gambit/defines.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GameControlWidget extends StatelessWidget {
  GameControlWidget({super.key});

  final BoardController bC = Get.find();
  final GameController gC = Get.find();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(children: [
        const Positioned.fill(
            child: Image(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
        )),
        Center(child: Obx(() {
          double width = MediaQuery.sizeOf(context).width;
          double height = MediaQuery.sizeOf(context).height;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 5,
                height: height / 30,
                child: AutoSizeText("Player: ${gC.turnState.value.name}",
                    maxLines: 1),
              ),
              SizedBox(
                width: width / 5,
                height: height / 30,
                child: gC.turnState.value == PieceColor.black
                    ? AutoSizeText(
                        "Energy Stored: ${gC.blackPlayer.value.powerStored}",
                        maxLines: 1,
                      )
                    : AutoSizeText(
                        "Energy Stored: ${gC.whitePlayer.value.powerStored}",
                        maxLines: 1),
              ),
              SizedBox(
                width: width / 5,
                height: height / 30,
                child: gC.turnState.value == PieceColor.black
                    ? AutoSizeText(
                        "Max Energy: ${gC.blackPlayer.value.powerStorage}",
                        maxLines: 1)
                    : AutoSizeText(
                        "Max Energy: ${gC.whitePlayer.value.powerStorage}",
                        maxLines: 1),
              ),
              SizedBox(
                  width: width / 5,
                  height: height / 30,
                  child: gC.pieceSelected.value
                      ? AutoSizeText(
                          "Piece selected: ${gC.selectedPieceType.value.name}",
                          maxLines: 1)
                      : Container()),
              SizedBox(
                  width: width / 5,
                  height: height / 30,
                  child: gC.pieceSelected.value
                      ? AutoSizeText(
                          "Energy Cost: ${gC.selectedPieceEnergyCost.value}",
                          maxLines: 1)
                      : Container()),
              SizedBox(
                  width: width / 5,
                  height: height / 30,
                  child: gC.pieceSelected.value
                      ? AutoSizeText(
                          "Energy Generation: ${gC.selectedPieceEnergyGeneration.value}",
                          maxLines: 1)
                      : Container()),
              SizedBox(
                  width: width / 5,
                  height: height / 30,
                  child: gC.pieceSelected.value
                      ? AutoSizeText("Row: ${gC.selectedPieceRow.value}",
                          maxLines: 1)
                      : Container()),
              SizedBox(
                  width: width / 5,
                  height: height / 30,
                  child: gC.pieceSelected.value
                      ? AutoSizeText("Col: ${gC.selectedPieceCol.value}",
                          maxLines: 1)
                      : Container()),
            ],
          );
        }))
      ]),
    );
  }
}

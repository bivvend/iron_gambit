import 'package:iron_gambit/classes/side.dart';
import 'package:iron_gambit/defines.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  // Controller to store game status.
  //Passive controller.   Board controller can call methods here
  //Bit not the other way round.
  Rx<PieceColor> turnState = PieceColor.black.obs;
  int count = 0;
  Rx<Side> whitePlayer = Side(PieceColor.white.obs, initialEnergy.obs, 0.obs)
      .obs; //Storage calculated later
  Rx<Side> blackPlayer = Side(PieceColor.black.obs, initialEnergy.obs, 0.obs)
      .obs; //Storage calculated later

  RxBool moveSelected = false.obs;
  RxBool attackSelected = false.obs;
  RxBool buildSelected = false.obs;

  RxBool pieceSelected = false.obs;
  Rx<PieceType> selectedPieceType = PieceType.worker.obs;
  RxInt selectedPieceRow = 0.obs;
  RxInt selectedPieceCol = 0.obs;
  RxInt selectedPieceEnergyCost = 0.obs;
  RxInt selectedPieceEnergyGeneration = 0.obs;
  RxList<ActionType> selectedPieceActions = <ActionType>[].obs;

  GameController() {
    // Future.doWhile(() async {
    //   await Future.delayed(Duration(seconds: 3));
    //   if (turnState.value == PieceColor.black) {
    //     turnState.value = PieceColor.white;
    //     return true;

    //   } else if (turnState.value == PieceColor.white) {
    //     turnState.value = PieceColor.black;
    //     return true;
    //   }
    //   return false;
    // });
  }

  void endTurn() {
    if (turnState.value == PieceColor.black) {
      turnState.value = PieceColor.white;
    } else if (turnState.value == PieceColor.white) {
      turnState.value = PieceColor.black;
    }
    pieceSelected.value = false;
    moveSelected.value = true;
    attackSelected.value = false;
    buildSelected.value = false;
    selectedPieceActions.clear();
  } //End turn

  void selectPiece(PieceType type, List<ActionType> actions, int row, int col) {
    selectedPieceType.value = type;
    selectedPieceRow.value = row;
    selectedPieceCol.value = col;

    if (type == PieceType.worker) {
      selectedPieceEnergyCost.value = energyCostWorker;
    } else if (type == PieceType.tank) {
      selectedPieceEnergyCost.value = energyCostTank;
    } else if (type == PieceType.gun) {
      selectedPieceEnergyCost.value = energyCostGun;
    } else if (type == PieceType.mech) {
      selectedPieceEnergyCost.value = energyCostMech;
    } else {
      selectedPieceEnergyCost.value = 0;
    }

    selectedPieceActions.clear();
    selectedPieceActions.addAll(actions);

    moveSelected.value = true;
    attackSelected.value = false;
    buildSelected.value = false;
    // if (actions.contains(ActionType.move)) {
    //   moveSelected.value = true;
    // } else {
    //   moveSelected.value = false;
    // }
    // if (actions.contains(ActionType.attack)) {
    //   attackSelected.value = true;
    // } else {
    //   attackSelected.value = false;
    // }
    // if (actions.contains(ActionType.build)) {
    //   buildSelected.value = true;
    // } else {
    //   buildSelected.value = false;
    // }

    if (type == PieceType.generator) {
      selectedPieceEnergyGeneration.value = energyGenerationGenerator;
    } else {
      selectedPieceEnergyGeneration.value = 0;
    }

    pieceSelected.value = true;
  }
}

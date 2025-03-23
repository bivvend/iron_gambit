import 'package:iron_gambit/classes/side.dart';
import 'package:iron_gambit/controllers/board_controller.dart';
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
}

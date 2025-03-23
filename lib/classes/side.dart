import 'package:iron_gambit/defines.dart';
import 'package:get/get.dart';

class Side {
  RxInt powerStored;
  RxInt powerStorage;
  Rx<PieceColor> colour;

  Side(this.colour, this.powerStored, this.powerStorage);
}

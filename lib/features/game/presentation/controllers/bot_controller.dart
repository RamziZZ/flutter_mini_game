import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';

class BotController extends GetxController {

  Timer? botTimer;

  final rand = Random();

  void startBots(){

    botTimer = Timer.periodic(
        Duration(seconds:2),(timer){

      // choose random tower
      // solve using BFS
      // commit to firebase

    });

  }

  void stopBots(){

    botTimer?.cancel();

  }

}
import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../data/datasources/firebase_game_datasource.dart';

class GameController extends GetxController {

  final FirebaseGameDatasource datasource;

  GameController(this.datasource);

  /// UI STATE
  var towersA = <Map<String, dynamic>>[].obs;
  var towersB = <Map<String, dynamic>>[].obs;

  var scoreA = 0.obs;
  var scoreB = 0.obs;

  /// GAME TIMER
  RxInt timeLeft = 300.obs;

  /// timers
  Timer? heartbeat;
  Timer? botTimer;
  Timer? afkTimer;
  Timer? matchTimer;

  /// firebase listener
  StreamSubscription<DatabaseEvent>? matchListener;

  final String matchId = "match1";

  final int winScore = 500;

  bool winnerShown = false;

  @override
  void onInit() {
    super.onInit();

    print("GAME CONTROLLER START");

    generateTowers();
    listenMatch();
    startBot();
    startTimer();
  }

  /// =========================
  /// GENERATE 20 TOWERS
  /// =========================

  Future<void> generateTowers() async {

    final rand = Random();

    Map<String, dynamic> towersAData = {};
    Map<String, dynamic> towersBData = {};

    for (int i = 1; i <= 20; i++) {

      towersAData["tower$i"] = {
        "id": "tower$i",
        "startValue": rand.nextInt(400) + 100,
        "state": "available"
      };

      towersBData["tower$i"] = {
        "id": "tower$i",
        "startValue": rand.nextInt(400) + 100,
        "state": "available"
      };
    }

    await datasource.db
        .child("liveMatches/$matchId/teams/A")
        .update({
      "towers": towersAData,
      "score": 0
    });

    await datasource.db
        .child("liveMatches/$matchId/teams/B")
        .update({
      "towers": towersBData,
      "score": 0
    });

    print("20 TOWERS CREATED");
  }

  /// =========================
  /// REALTIME MATCH LISTENER
  /// =========================

  void listenMatch() {

    matchListener = datasource.db
        .child("liveMatches/$matchId")
        .onValue
        .listen((event) {

      final data = event.snapshot.value;

      if (data == null) return;

      final map = Map<String, dynamic>.from(data as Map);

      final teams = Map<String, dynamic>.from(map["teams"] ?? {});

      /// TEAM A
      final towersAMap =
      Map<String, dynamic>.from(teams["A"]?["towers"] ?? {});

      towersA.value = towersAMap.entries.map((entry) {
        final tower = Map<String, dynamic>.from(entry.value);
        tower["id"] = entry.key;
        return tower;
      }).toList();

      /// TEAM B
      final towersBMap =
      Map<String, dynamic>.from(teams["B"]?["towers"] ?? {});

      towersB.value = towersBMap.entries.map((entry) {
        final tower = Map<String, dynamic>.from(entry.value);
        tower["id"] = entry.key;
        return tower;
      }).toList();

      /// SCORE
      scoreA.value = teams["A"]?["score"] ?? 0;
      scoreB.value = teams["B"]?["score"] ?? 0;

      checkWinner();
    });
  }

  /// =========================
  /// CLAIM TOWER
  /// =========================

  Future<void> claimTower(
      String team,
      String towerId,
      String uid
      ) async {

    await datasource.claimTower(
      matchId,
      team,
      towerId,
      uid,
    );
  }

  /// =========================
  /// SOLVE TOWER
  /// =========================

  Future<void> solveTower(
      String team,
      String towerId,
      String uid
      ) async {

    int movesTaken = Random().nextInt(5) + 3;
    int optimalMoves = 3;

    bool success = await datasource.solveTower(
        matchId,
        team,
        towerId,
        uid,
        movesTaken,
        optimalMoves
    );

    if (success) {

      int addScore = 100;

      await datasource.db
          .child("liveMatches/$matchId/teams/$team/score")
          .runTransaction((data) {

        int current = (data ?? 0) as int;
        int newScore = current + addScore;

        return Transaction.success(newScore);
      });
    }
  }

  /// =========================
  /// BOT AI
  /// =========================

  void startBot() {

    botTimer = Timer.periodic(
        const Duration(seconds: 5),
            (timer) {

          if (towersB.isEmpty) return;

          int index = Random().nextInt(towersB.length);
          final tower = towersB[index];

          String towerId = tower["id"];

          if (tower["state"] == "available") {

            claimTower("B", towerId, "bot");

          } else if (tower["state"] == "claimed"
              && tower["claimedBy"] == "bot") {

            solveTower("B", towerId, "bot");
          }
        });
  }

  /// =========================
  /// HEARTBEAT
  /// =========================

  void startHeartbeat(String uid) {

    heartbeat = Timer.periodic(
        const Duration(seconds: 5),
            (timer) {

          datasource.db
              .child("players/$uid/lastSeenAt")
              .set(DateTime.now().millisecondsSinceEpoch);
        });
  }

  /// =========================
  /// AFK TRACKING
  /// =========================

  void startAFKTracking(String uid){

    afkTimer = Timer.periodic(
        const Duration(seconds: 5),
            (timer){

          FirebaseDatabase.instance
              .ref("players/$uid/lastSeenAt")
              .set(ServerValue.timestamp);

        }
    );
  }

  /// =========================
  /// MATCH TIMER
  /// =========================

  void startTimer(){

    matchTimer = Timer.periodic(
        const Duration(seconds:1),
            (timer){

          if(timeLeft.value <= 0){
            timer.cancel();
            return;
          }

          timeLeft.value--;

        }
    );
  }

  /// =========================
  /// WINNER CHECK
  /// =========================

  void checkWinner() {

    if(winnerShown) return;

    if (scoreA.value >= winScore) {

      winnerShown = true;

      Get.dialog(
        AlertDialog(
          title: const Text("TEAM A WIN"),
          content: const Text("Player menang!"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }

    if (scoreB.value >= winScore) {

      winnerShown = true;

      Get.dialog(
        AlertDialog(
          title: const Text("TEAM B WIN"),
          content: const Text("Bot menang!"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  /// =========================
  /// CLEANUP
  /// =========================

  @override
  void onClose() {

    heartbeat?.cancel();
    botTimer?.cancel();
    afkTimer?.cancel();
    matchTimer?.cancel();
    matchListener?.cancel();

    super.onClose();
  }
}
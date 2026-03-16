import 'package:firebase_database/firebase_database.dart';

abstract class GameRepository {

  Stream<DatabaseEvent> listenMatch(String matchId);

  Future<bool> claimTower(
    String matchId,
    String team,
    String towerId,
    String uid,
  );

  Future<bool> solveTower(
    String matchId,
    String team,
    String towerId,
    String uid,
    int movesTaken,
    int optimalMoves,
  );
}
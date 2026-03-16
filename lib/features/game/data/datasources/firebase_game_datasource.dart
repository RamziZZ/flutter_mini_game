import 'package:firebase_database/firebase_database.dart';

class FirebaseGameDatasource {

  final DatabaseReference db = FirebaseDatabase.instance.ref();

  /// listen realtime match
  Stream<DatabaseEvent> listenMatch(String matchId) {
    return db.child("liveMatches/$matchId").onValue;
  }

  /// CLAIM TOWER
  Future<bool> claimTower(
    String matchId,
    String team,
    String towerId,
    String uid,
  ) async {

    final towerRef =
        db.child("liveMatches/$matchId/teams/$team/towers/$towerId");

    final result = await towerRef.runTransaction((Object? data) {

      if (data == null) {
        return Transaction.abort();
      }

      final map = Map<String, dynamic>.from(data as Map);

      final state = map["state"] ?? "available";

      if (state == "available") {

        map["state"] = "claimed";
        map["claimedBy"] = uid;
        map["claimExpiresAt"] =
            DateTime.now().millisecondsSinceEpoch + 15000;

        return Transaction.success(map);
      }

      return Transaction.abort();
    });

    return result.committed;
  }

  /// SOLVE TOWER
  Future<bool> solveTower(
    String matchId,
    String team,
    String towerId,
    String uid,
    int movesTaken,
    int optimalMoves,
  ) async {

    final towerRef =
        db.child("liveMatches/$matchId/teams/$team/towers/$towerId");

    final result = await towerRef.runTransaction((Object? data) {

      if (data == null) {
        return Transaction.abort();
      }

      final map = Map<String, dynamic>.from(data as Map);

      if (map["claimedBy"] != uid) {
        return Transaction.abort();
      }

      map["state"] = "solved";
      map["solvedBy"] = uid;
      map["movesTaken"] = movesTaken;
      map["optimalMoves"] = optimalMoves;
      map["solvedAt"] = DateTime.now().millisecondsSinceEpoch;

      return Transaction.success(map);
    });

    return result.committed;
  }
}
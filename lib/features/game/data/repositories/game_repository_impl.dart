import '../../domain/repositories/game_repository.dart';
import '../datasources/firebase_game_datasource.dart';
import 'package:firebase_database/firebase_database.dart';

class GameRepositoryImpl implements GameRepository {

  final FirebaseGameDatasource datasource;

  GameRepositoryImpl(this.datasource);

  @override
  Stream<DatabaseEvent> listenMatch(String matchId) {
    return datasource.listenMatch(matchId);
  }

  @override
  Future<bool> claimTower(
      String matchId, String team, String towerId, String uid) {
    return datasource.claimTower(matchId, team, towerId, uid);
  }

  @override
  Future<bool> solveTower(
      String matchId,
      String team,
      String towerId,
      String uid,
      int movesTaken,
      int optimalMoves) {

    return datasource.solveTower(
        matchId, team, towerId, uid, movesTaken, optimalMoves);
  }
}
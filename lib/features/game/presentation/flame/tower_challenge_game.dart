import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'tower_component.dart';

class TowerChallengeGame extends FlameGame with TapCallbacks {

  final String team;

  TowerChallengeGame({required this.team});

  @override
  Future<void> onLoad() async {

    for (int i = 0; i < 20; i++) {

      final tower = TowerComponent(
        startValue: 10,
        state: "available",
      );

      tower.position = Vector2(
        (i % 5) * 80,
        (i ~/ 5) * 80,
      );

      add(tower);
    }
  }
}
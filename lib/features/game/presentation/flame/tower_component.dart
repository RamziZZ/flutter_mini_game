import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import 'package:get/get.dart';

class TowerComponent extends PositionComponent with TapCallbacks {

  int startValue;
  int targetValue;
  String state;

  late RectangleComponent box;
  late TextComponent label;

  TowerComponent({
    required this.startValue,
    required this.targetValue,
    required this.state,
  });

  Color getTowerColor() {

    switch (state) {

      case "available":
        return Colors.grey;

      case "claimed":
        return Colors.orange;

      case "solved":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Future<void> onLoad() async {

    size = Vector2(70, 70);

    box = RectangleComponent(
      size: size,
      paint: Paint()..color = getTowerColor(),
    );

    label = TextComponent(
      text: "$startValue → $targetValue",
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );

    add(box);
    add(label);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final controller = Get.find<GameController>();
    controller.openPuzzle(startValue, targetValue);

    print("Tower tapped");
  }
}
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class TowerComponent extends PositionComponent with TapCallbacks {

  final int startValue;
  final String state;

  late RectangleComponent box;

  TowerComponent({
    required this.startValue,
    required this.state,
  });

  @override
  Future<void> onLoad() async {

    size = Vector2(60, 60);

    box = RectangleComponent(
      size: size,
      paint: Paint()
        ..color = Colors.blue,
    );

    add(box);
  }

  @override
  void onTapDown(TapDownEvent event) {
    print("Tower tapped!");
  }
}
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class TowerComponent extends PositionComponent with TapCallbacks {

  final int startValue;
  String state;

  TowerComponent({
    required this.startValue,
    required this.state,
  });

  @override
  Future<void> onLoad() async {

    size = Vector2(60,60);

  }

  @override
  void render(Canvas canvas) {

    final paint = Paint();

    if(state == "available"){
      paint.color = Colors.green;
    }
    else if(state == "claimed"){
      paint.color = Colors.yellow;
    }
    else{
      paint.color = Colors.grey;
    }

    canvas.drawRect(size.toRect(), paint);

  }

  @override
  void onTapDown(TapDownEvent event) {
    print("Tower tapped: $startValue");
  }

}
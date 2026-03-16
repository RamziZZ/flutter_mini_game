import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class TowerCard extends StatelessWidget {

  final int startValue;
  final String state;
  final String towerId;
  final String team;
  final bool isSolving;

  const TowerCard({
    super.key,
    required this.startValue,
    required this.state,
    required this.towerId,
    required this.team,
    this.isSolving = false,
  });

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<GameController>();

    double height = startValue / 4;

    Color color;

    switch (state) {
      case "claimed":
        color = Colors.orange;
        break;
      case "solved":
        color = Colors.green;
        break;
      default:
        color = Colors.purple;
    }

    return GestureDetector(

      onTap: () {

        if(state == "available"){
          controller.claimTower(team, towerId, "player1");
        }

        else if(state == "claimed"){
          controller.solveTower(team, towerId, "player1");
        }

      },

      child: Container(

        alignment: Alignment.bottomCenter,

        child: AnimatedContainer(

          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,

          width: 45,
          height: height,

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),

          child: Stack(

            alignment: Alignment.center,

            children: [

              /// tower value
              Text(
                startValue.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// claimed icon
              if(state == "claimed")
                const Icon(
                  Icons.flash_on,
                  color: Colors.white,
                  size: 20,
                ),

              /// solved icon
              if(state == "solved")
                const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 20,
                ),

              /// solving progress
              if(isSolving)
                const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
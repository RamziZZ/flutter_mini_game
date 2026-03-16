import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class TowerCard extends StatefulWidget {

  final int startValue;
  final String state;
  final String towerId;
  final String team;
  final bool isSolving;
  final double width;

  const TowerCard({
    super.key,
    required this.startValue,
    required this.state,
    required this.towerId,
    required this.team,
    required this.width,
    this.isSolving = false,
  });

  @override
  State<TowerCard> createState() => _TowerCardState();
}

class _TowerCardState extends State<TowerCard>
    with SingleTickerProviderStateMixin {

  late AnimationController glowController;
  late Animation<double> glowAnimation;

  final controller = Get.find<GameController>();

  late String avatar;

  @override
  void initState() {
    super.initState();

    avatar = "https://i.pravatar.cc/150?img=${Random().nextInt(60)}";

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    glowAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: glowController, curve: Curves.easeOut),
    );

    if (widget.state == "solved") {
      glowController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant TowerCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != "solved" && widget.state == "solved") {
      glowController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// tinggi tower responsive
    double height = (widget.startValue * 1.5).clamp(35, 160);

    Color color;

    switch (widget.state) {
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

        if (widget.state == "available") {
          controller.claimTower(widget.team, widget.towerId, "player1");
        }

        else if (widget.state == "claimed") {
          controller.solveTower(widget.team, widget.towerId, "player1");
        }

      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          /// TOWER
          AnimatedBuilder(
            animation: glowAnimation,
            builder: (context, child) {

              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,

                width: widget.width,
                height: height,

                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: widget.state == "solved"
                      ? [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.7),
                            blurRadius: glowAnimation.value,
                            spreadRadius: glowAnimation.value / 2,
                          )
                        ]
                      : [],
                ),

                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Text(
                      widget.startValue.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (widget.state == "claimed")
                      const Icon(
                        Icons.flash_on,
                        color: Colors.white,
                        size: 18,
                      ),

                    if (widget.state == "solved")
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 18,
                      ),

                    if (widget.isSolving)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 6),

          /// AVATAR
          CircleAvatar(
            radius: widget.width / 3,
            backgroundImage: NetworkImage(avatar),
          ),
        ],
      ),
    );
  }
}
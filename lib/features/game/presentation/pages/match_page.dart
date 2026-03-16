import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../widgets/tower_card.dart';

class MatchPage extends GetView<GameController> {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tower Battle"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          /// SCORE
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Score A ${controller.scoreA} : ${controller.scoreB} Score B",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),

          /// TEAM A
          Expanded(
            child: teamArena(context, "TEAM A", controller.towersA),
          ),

          const Divider(height: 2),

          /// TEAM B
          Expanded(
            child: teamArena(context, "TEAM B", controller.towersB),
          ),
        ],
      ),
    );
  }

  Widget teamArena(
    BuildContext context,
    String team,
    RxList<Map<String, dynamic>> towers,
  ) {
    return Column(
      children: [

        const SizedBox(height: 10),

        Text(
          team,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF7BC8A4),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Obx(() {

              if (towers.isEmpty) {
                return const Center(child: Text("No Towers"));
              }

              return LayoutBuilder(
                builder: (context, constraints) {

                  double width = constraints.maxWidth;

                  /// tower width responsive
                  double towerWidth = width / (towers.length * 1.6);

                  /// clamp supaya tidak terlalu kecil / besar
                  towerWidth = towerWidth.clamp(28, 60);

                  /// spacing tower
                  double spacing = width / towers.length;

                  return Stack(
                    children: [

                      /// GROUND
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                        ),
                      ),

                      /// TOWERS
                      ...List.generate(towers.length, (i) {

                        final tower = towers[i];

                        return Positioned(
                          bottom: 35,
                          left: spacing * i + spacing / 2 - towerWidth / 2,
                          child: TowerCard(
                            width: towerWidth,
                            towerId: tower["id"],
                            team: team == "TEAM A" ? "A" : "B",
                            startValue: tower["startValue"] ?? 0,
                            state: tower["state"] ?? "available",
                          ),
                        );

                      }),
                    ],
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
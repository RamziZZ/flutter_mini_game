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

          Obx(() {

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Score A ${controller.scoreA}  :  ${controller.scoreB} Score B",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );

          }),

          /// TEAM A
          Expanded(
            child: teamArena("TEAM A", controller.towersA),
          ),

          const Divider(),

          /// TEAM B
          Expanded(
            child: teamArena("TEAM B", controller.towersB),
          ),

        ],

      ),

    );
  }

  Widget teamArena(String team, RxList<Map<String, dynamic>> towers){

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

          child: Obx(() {

            if (towers.isEmpty) {
              return const Center(
                child: Text("No Towers"),
              );
            }

            return GridView.builder(

              padding: const EdgeInsets.all(8),

              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,

              ),

              itemCount: towers.length,

              itemBuilder: (_, i) {

                final tower = towers[i];

                return TowerCard(

                  towerId: tower["id"],

                  team: team == "TEAM A" ? "A" : "B",

                  startValue: tower["startValue"] ?? 0,

                  state: tower["state"] ?? "available",

                );

              },

            );

          }),

        )

      ],

    );

  }

}
import 'package:flutter/material.dart';
import 'package:flutter_game/features/game/data/repositories/game_repository_impl.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'features/game/presentation/pages/match_page.dart';
import 'features/game/presentation/controllers/game_controller.dart';
import 'features/game/presentation/controllers/bot_controller.dart';
import 'features/game/data/datasources/firebase_game_datasource.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// initialize firebase (WAJIB pakai ini jika ada firebase_options.dart)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// dependency injection
  Get.put(FirebaseGameDatasource());

  Get.put(GameRepositoryImpl(Get.find()));

  Get.put(GameController(Get.find()));

  Get.put(BotController());

  runApp(const TowerBattleApp());
}

class TowerBattleApp extends StatelessWidget {
  const TowerBattleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tower Battle",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MatchPage(),
    );
  }
}
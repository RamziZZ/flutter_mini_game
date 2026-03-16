import 'dart:math';

class TowerGenerator {

  static List<int> generateTowers(){

    final random = Random();

    return List.generate(
      20,
      (_) => random.nextInt(95) + 5,
    );

  }

}
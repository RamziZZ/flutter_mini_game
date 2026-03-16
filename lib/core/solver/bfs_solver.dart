class BFSSolver {

  /// mencari langkah minimal dari start ke target
  static int solve(int start, int target) {

    if (start == target) return 0;

    final visited = <int>{};
    final queue = <Map<String, int>>[];

    queue.add({
      "value": start,
      "moves": 0,
    });

    visited.add(start);

    while (queue.isNotEmpty) {

      final node = queue.removeAt(0);

      int value = node["value"]!;
      int moves = node["moves"]!;

      List<int> nextValues = [
        value + 1,
        value - 1,
        value * 2,
      ];

      for (var next in nextValues) {

        if (next == target) {
          return moves + 1;
        }

        if (!visited.contains(next) && next >= 0 && next <= 1000) {

          visited.add(next);

          queue.add({
            "value": next,
            "moves": moves + 1,
          });

        }
      }
    }

    return -1;
  }
}
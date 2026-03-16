import 'dart:collection';

class BFSSolver {

  static int solve(int start, int target){

    Queue<Map<String,int>> queue = Queue();
    Set<int> visited = {};

    queue.add({
      "value": start,
      "moves": 0
    });

    while(queue.isNotEmpty){

      final node = queue.removeFirst();

      int value = node["value"]!;
      int moves = node["moves"]!;

      if(value == target){
        return moves;
      }

      if(visited.contains(value)) continue;

      visited.add(value);

      int add = value + 10;
      int mul = value * 2;

      if(add <= 200000){
        queue.add({"value": add, "moves": moves+1});
      }

      if(mul <= 200000){
        queue.add({"value": mul, "moves": moves+1});
      }

    }

    return -1;

  }

}
class Tower {

  final String id;

  final int startValue;

  final String state;

  final String? claimedBy;

  final int? moves;

  Tower({

    required this.id,

    required this.startValue,

    required this.state,

    this.claimedBy,

    this.moves

  });

}
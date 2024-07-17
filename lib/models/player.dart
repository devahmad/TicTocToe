class Player {
  final String playername;
  final String socketID;
  final double points;
  final String playerType;

  Player(
      {required this.playername,
      required this.socketID,
      required this.points,
      required this.playerType});

  Map<String, dynamic> toMap() {
    return {
      'playername': playername,
      'socketID': socketID,
      'points': points,
      'playerType': playerType
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
        playername: map['playername'] ?? '',
        socketID: map['socketID'] ?? '',
        points: map['points']?.toDouble() ?? 0.0,
        playerType: map['playerType'] ?? '');
  }
}

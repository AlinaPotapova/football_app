class FootballMatch {
  final String date;
  final String firstPlayerName;
  final String secondPlayerName;
  final int player1Score;
  final int player2Score;

  FootballMatch({
    required this.date,
    required this.firstPlayerName,
    required this.secondPlayerName,
    required this.player1Score,
    required this.player2Score,
    required String winner,
  });

  // Convert JSON map to Match object
  factory FootballMatch.fromJson(Map<String, dynamic> json) {
    return FootballMatch(
      date: json['date'] as String,
      firstPlayerName: json['firstPlayerName'] as String,
      secondPlayerName: json['secondPlayerName'] as String,
      player1Score: json['player1Score'] as int,
      player2Score: json['player2Score'] as int,
      winner: '',
    );
  }

  // Convert Match object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'firstPlayerName': firstPlayerName,
      'secondPlayerName': secondPlayerName,
      'player1Score': player1Score,
      'player2Score': player2Score,
    };
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:football_tournament/core/model/football_match.dart';

void main() {
  group('FootballMatch serialization', () {
    test('fromJson creates FootballMatch with expected fields', () {
      final json = {
        'date': '2025-10-20',
        'firstPlayerName': 'Alice',
        'secondPlayerName': 'Bob',
        'player1Score': 3,
        'player2Score': 1,
      };

      final match = FootballMatch.fromJson(json);

      expect(match.date, '2025-10-20');
      expect(match.firstPlayerName, 'Alice');
      expect(match.secondPlayerName, 'Bob');
      expect(match.player1Score, 3);
      expect(match.player2Score, 1);
    });

    test('toJson returns a map with expected keys/values', () {
      final match = FootballMatch(
        date: '2025-10-20',
        firstPlayerName: 'Alice',
        secondPlayerName: 'Bob',
        player1Score: 2,
        player2Score: 2,
        winner: '',
      );

      final json = match.toJson();

      expect(json['date'], '2025-10-20');
      expect(json['firstPlayerName'], 'Alice');
      expect(json['secondPlayerName'], 'Bob');
      expect(json['player1Score'], 2);
      expect(json['player2Score'], 2);
    });
  });
}

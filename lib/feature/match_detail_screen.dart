import 'package:flutter/material.dart';
import 'package:football_tournament/core/model/football_match.dart'; // adjust import path

class MatchDetailScreen extends StatelessWidget {
  final FootballMatch match;

  const MatchDetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${match.firstPlayerName} vs ${match.secondPlayerName}'),
        backgroundColor: const Color(0xFFFF6F00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '${match.player1Score} - ${match.player2Score}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '📅 Date: ${match.date}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 12),
            Text(
              '👤 First Player: ${match.firstPlayerName}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              '👤 Second Player: ${match.secondPlayerName}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

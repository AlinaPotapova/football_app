import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_tournament/core/model/football_match.dart';
import 'package:football_tournament/feature/recent_games/cubit/recent_games_cubit.dart';

class RecordNewGameScreen extends StatefulWidget {
  const RecordNewGameScreen({super.key});

  @override
  State<RecordNewGameScreen> createState() => _RecordNewGameScreenState();
}

class _RecordNewGameScreenState extends State<RecordNewGameScreen> {
  final player1NameController = TextEditingController();
  final player2NameController = TextEditingController();
  final player1ScoreController = TextEditingController(text: "0");
  final player2ScoreController = TextEditingController(text: "0");
  int winner = 1;
  late final RecentGamesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        cubit = RecentGamesCubit();
        cubit.init();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Record New Game",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
        ),
        body: BlocBuilder<RecentGamesCubit, RecentGamesState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPlayerCard(
                    title: "Player 1",
                    nameController: player1NameController,
                    scoreController: player1ScoreController,
                  ),
                  const SizedBox(height: 16),
                  _buildPlayerCard(
                    title: "Player 2",
                    nameController: player2NameController,
                    scoreController: player2ScoreController,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Winner",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _winnerButton("Player 1", 1, Colors.green),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _winnerButton("Player 2", 2, Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  cubit.addMatch(
                    FootballMatch(
                      date: DateTime.now().toString(),
                      firstPlayerName: player1NameController.text,
                      secondPlayerName: player2NameController.text,
                      player1Score:
                          int.tryParse(player1ScoreController.text) ?? 0,
                      player2Score:
                          int.tryParse(player2ScoreController.text) ?? 0,
                      winner:
                          winner == 1
                              ? player1NameController.text
                              : player2NameController.text,
                    ),
                  );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Game Saved!")));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save Game",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerCard({
    required String title,
    required TextEditingController nameController,
    required TextEditingController scoreController,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          const Text(
            "Player Name",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Enter Player Name"),
          ),
          const SizedBox(height: 16),
          const Text(
            "Score",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: scoreController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "0"),
          ),
        ],
      ),
    );
  }

  Widget _winnerButton(String label, int value, Color activeColor) {
    final bool isSelected = winner == value;
    return OutlinedButton(
      onPressed: () {
        setState(() => winner = value);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor:
            // ignore: deprecated_member_use
            isSelected ? activeColor.withOpacity(0.15) : Colors.transparent,
        side: BorderSide(
          color: isSelected ? activeColor : Colors.grey.shade400,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? activeColor : Colors.black87,
        ),
      ),
    );
  }
}

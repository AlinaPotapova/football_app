import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_tournament/feature/match_detail_screen.dart';
import 'package:football_tournament/feature/recent_games/cubit/recent_games_cubit.dart';

class RecentGamesScreen extends StatelessWidget {
  const RecentGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recent Games',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/record_new_game').then((_) {
            // ignore: use_build_context_synchronously
            context.read<RecentGamesCubit>().init();
          });
        },
        backgroundColor: const Color(0xFFFF6F00),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<RecentGamesCubit, RecentGamesState>(
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.matches?.length ?? 0,
            itemBuilder: (context, index) {
              if (state.matches?.isEmpty ?? true) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        'Oops! No recent games found.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tap the + button to record a new game.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              final game = state.matches![index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 151, 182, 229),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green.shade700,
                    child: const Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(255, 208, 207, 223),
                    ),
                  ),
                  title: Text(
                    game.date.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '${game.firstPlayerName} vs ${game.secondPlayerName}',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 46, 62, 205),
                      ),
                    ),
                  ),
                  trailing: Text(
                    '${game.player1Score} - ${game.player2Score}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MatchDetailScreen(match: game),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

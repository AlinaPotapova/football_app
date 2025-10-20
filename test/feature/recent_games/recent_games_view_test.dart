import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_tournament/core/model/football_match.dart';
import 'package:football_tournament/feature/game/service/game_service.dart';
import 'package:football_tournament/feature/recent_games/cubit/recent_games_cubit.dart';
import 'package:football_tournament/feature/recent_games/view/recent_games_view.dart';

class _FakeRecentGamesCubit extends Cubit<RecentGamesState>
    implements RecentGamesCubit {
  _FakeRecentGamesCubit(super.initial);

  @override
  void init() {}

  @override
  void setContext(BuildContext context) {}

  @override
  IGameService get service => throw UnimplementedError();

  @override
  BuildContext? context;

  @override
  Future<void> addMatch(FootballMatch newGame) {
    throw UnimplementedError();
  }
}

void main() {
  Widget wrapWithProvider(RecentGamesState state) {
    return MaterialApp(
      home: BlocProvider<RecentGamesCubit>(
        create: (_) => _FakeRecentGamesCubit(state),
        child: const RecentGamesScreen(),
      ),
    );
  }

  testWidgets('renders a game tile when there is at least one match', (
    tester,
  ) async {
    final match = FootballMatch(
      date: '2025-10-22',
      firstPlayerName: 'Alice',
      secondPlayerName: 'Bob',
      player1Score: 2,
      player2Score: 1,
      winner: '',
    );
    final populatedState = RecentGamesState(matches: <FootballMatch>[match]);

    await tester.pumpWidget(wrapWithProvider(populatedState));
    await tester.pump();

    expect(find.text('2025-10-22'), findsOneWidget);
    expect(find.text('Alice vs Bob'), findsOneWidget);
    expect(find.text('2 - 1'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:football_tournament/core/model/football_match.dart';
import 'package:football_tournament/datasource/football_match_datasource.dart';
import 'package:football_tournament/di/dependency_injection.dart';
import 'package:football_tournament/feature/game/service/game_service.dart';

class _FakeDataSource implements IFootballMatchDataSource {
  _FakeDataSource(this._storage);

  final List<FootballMatch> _storage;

  @override
  Future addMatch(FootballMatch newGame) async {
    _storage.add(newGame);
  }

  @override
  Future<List<FootballMatch>> fetchMatches() async {
    return List<FootballMatch>.from(_storage);
  }
}

void main() {
  late List<FootballMatch> backingStore;

  setUp(() {
    // fresh backing store each test
    backingStore = <FootballMatch>[];

    // Reset and register our fake for the 'local' instance
    if (getIt.isRegistered<IFootballMatchDataSource>(instanceName: 'local')) {
      getIt.unregister<IFootballMatchDataSource>(instanceName: 'local');
    }
    getIt.registerFactory<IFootballMatchDataSource>(
      () => _FakeDataSource(backingStore),
      instanceName: 'local',
    );

    // Ensure service binding exists
    if (getIt.isRegistered<IGameService>()) {
      getIt.unregister<IGameService>();
    }
    getIt.registerFactory<IGameService>(() => GameService());
  });

  tearDown(() async {
    // Keep other singletons but remove our test overrides
    if (getIt.isRegistered<IFootballMatchDataSource>(instanceName: 'local')) {
      getIt.unregister<IFootballMatchDataSource>(instanceName: 'local');
    }
    if (getIt.isRegistered<IGameService>()) {
      getIt.unregister<IGameService>();
    }
  });

  test('getMatches returns matches from data source', () async {
    backingStore.add(
      FootballMatch(
        date: '2025-10-20',
        firstPlayerName: 'Alice',
        secondPlayerName: 'Bob',
        player1Score: 3,
        player2Score: 2,
        winner: '',
      ),
    );

    final service = getIt<IGameService>();
    final result = await service.getMatches();

    expect(result.length, 1);
    expect(result.first.firstPlayerName, 'Alice');
    expect(result.first.secondPlayerName, 'Bob');
  });

  test('addMatch adds a match to data source', () async {
    final service = getIt<IGameService>();

    final newGame = FootballMatch(
      date: '2025-10-21',
      firstPlayerName: 'Carol',
      secondPlayerName: 'Dave',
      player1Score: 1,
      player2Score: 0,
      winner: '',
    );

    await service.addMatch(newGame);

    final matches = await service.getMatches();
    expect(matches.length, 1);
    expect(matches.first.firstPlayerName, 'Carol');
    expect(matches.first.secondPlayerName, 'Dave');
  });
}

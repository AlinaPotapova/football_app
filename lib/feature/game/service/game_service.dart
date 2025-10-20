import 'package:football_tournament/core/model/football_match.dart';
import 'package:football_tournament/datasource/football_match_datasource.dart';
import 'package:football_tournament/di/dependency_injection.dart';

abstract class IGameService {
  Future<List<FootballMatch>> getMatches();
  Future<void> addMatch(FootballMatch newGame);
}

class GameService implements IGameService {
  @override
  Future<List<FootballMatch>> getMatches() async {
    final match = await dataSource.fetchMatches();
    return match;
  }

  @override
  Future<void> addMatch(FootballMatch newGame) async {
    await dataSource.addMatch(newGame);
  }

  IFootballMatchDataSource get dataSource =>
      getIt<IFootballMatchDataSource>(instanceName: 'local');
}

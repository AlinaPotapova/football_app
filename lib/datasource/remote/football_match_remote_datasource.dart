import 'package:football_tournament/core/model/football_match.dart';
import 'package:football_tournament/datasource/football_match_datasource.dart';

class FootballMatchRemoteDatasource implements IFootballMatchDataSource {
  @override
  Future<List<FootballMatch>> fetchMatches() {
    throw UnimplementedError();
  }

  @override
  Future<void> addMatch(FootballMatch newGame) {
    throw UnimplementedError();
  }
}

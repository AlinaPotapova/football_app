import 'package:football_tournament/core/model/football_match.dart';

abstract class IFootballMatchDataSource {
  Future<List<FootballMatch>> fetchMatches();
  Future addMatch(FootballMatch newGame);
}

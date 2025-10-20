import 'dart:convert';

import 'package:football_tournament/core/constant/shared_pref_key.dart';
import 'package:football_tournament/core/init/shared_preference.dart';
import 'package:football_tournament/core/model/football_match.dart';
import 'package:football_tournament/datasource/football_match_datasource.dart';

class FootballMatchLocalDatasource implements IFootballMatchDataSource {
  final _prefs = SharedPrefsManager.instance;

  @override
  Future<List<FootballMatch>> fetchMatches() async {
    final data = _prefs.getStringValue(PrefsKeys.matches);

    if (data.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(data) as List<dynamic>;
    return Future.value(
      decoded.map<FootballMatch>((d) => FootballMatch.fromJson(d)).toList(),
    );
  }

  @override
  Future<void> addMatch(FootballMatch match) async {
    final matches = await fetchMatches();
    matches.add(match);
    final encoded = jsonEncode(matches);
    await _prefs.setStringValue(PrefsKeys.matches, encoded);
  }
}

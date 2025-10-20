import 'package:dio/dio.dart';
import 'package:football_tournament/datasource/football_match_datasource.dart';
import 'package:football_tournament/datasource/local/football_match_local_datasource.dart';
import 'package:football_tournament/datasource/remote/football_match_remote_datasource.dart';
import 'package:football_tournament/feature/game/service/game_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
final dio = Dio();

void setupGetIt() {
  getIt.registerLazySingleton<IFootballMatchDataSource>(
    () => FootballMatchLocalDatasource(),
    instanceName: 'local',
  );
  getIt.registerLazySingleton<IFootballMatchDataSource>(
    () => FootballMatchRemoteDatasource(),
    instanceName: 'remote',
  );
  getIt.registerLazySingleton<IGameService>(() => GameService());
}

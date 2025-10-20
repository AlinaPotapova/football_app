import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_tournament/core/cubit/base_cubit.dart';
import 'package:football_tournament/core/model/football_match.dart';
import 'package:football_tournament/di/dependency_injection.dart';
import 'package:football_tournament/feature/game/service/game_service.dart';

part 'recent_games_state.dart';

class RecentGamesCubit extends Cubit<RecentGamesState> with BaseCubit {
  RecentGamesCubit() : super(const RecentGamesState());

  @override
  void init() async {
    emit(state.copyWith(matches: await service.getMatches()));
  }

  Future<void> addMatch(FootballMatch newGame) async {
    service.addMatch(newGame);
    emit(state.copyWith(matches: await service.getMatches()));
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  IGameService get service => getIt<IGameService>();
}

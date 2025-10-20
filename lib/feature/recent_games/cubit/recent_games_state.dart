part of 'recent_games_cubit.dart';

class RecentGamesState extends Equatable {
  final bool isLoading;
  final String title;
  final List<FootballMatch>? matches;

  const RecentGamesState({
    this.matches,
    this.isLoading = false,
    this.title = 'Recent Games',
  });

  RecentGamesState copyWith({
    List<FootballMatch>? matches,
    bool? isLoading,
    String? title,
  }) {
    return RecentGamesState(
      matches: matches,
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [isLoading, matches, title];
}

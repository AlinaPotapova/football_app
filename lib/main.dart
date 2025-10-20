import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_tournament/core/init/shared_preference.dart';
import 'package:football_tournament/di/dependency_injection.dart';
import 'package:football_tournament/feature/recent_games/cubit/recent_games_cubit.dart';
import 'package:football_tournament/feature/recent_games/view/recent_games_view.dart';
import 'package:football_tournament/feature/record_new_game/record_new_game_view.dart';

void main() async {
  setupGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsManager.preferencesInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/record_new_game': (context) => RecordNewGameScreen()},
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) {
          final cubit = RecentGamesCubit();
          cubit.init();
          return cubit;
        },
        child: RecentGamesScreen(),
      ),
    );
  }
}

# football_tournament

A new Flutter project.

This is a simple football (soccer) app that records and shows recent matches.
It uses Cubit (from `flutter_bloc`) for state management and `get_it` for
dependency injection.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Prerequisites

- Flutter SDK installed and on your PATH
- Dart SDK bundled with Flutter

Verify your environment:

```bash
flutter doctor
```

## Install dependencies

```bash
flutter pub get
```

## Run the app

```bash
flutter run
```

Run on web (tested):

```bash
flutter run -d chrome
```

## Run tests

This project includes unit tests for the domain model and service layer.

```bash
flutter test
```

Notable tests:

- `test/core/model/football_match_test.dart` – verifies `FootballMatch.fromJson` and `toJson` behavior
- `test/feature/game/game_service_test.dart` – verifies `GameService.getMatches` and `addMatch` using a fake data source wired via `get_it`
 - `test/feature/recent_games/recent_games_view_test.dart` – widget test for `RecentGamesScreen` empty and populated states

Test coverage snapshot:

- 2 unit tests
- 1 widget test

## Project structure (high level)

- `lib/core` – shared building blocks (models, base cubit, constants)
- `lib/datasource` – `IFootballMatchDataSource` contract and local/remote implementations
- `lib/feature` – feature modules, including recent games and game service
- `lib/di/dependency_injection.dart` – `get_it` service locator setup

## Dependency Injection

The app uses `get_it` for DI. During tests, the data source and service can be overridden/registered with test doubles.

## Why Cubit for state management?

- **Simplicity**: Cubit exposes a minimal API (emit new states) without boilerplate events, making it easy to learn and maintain.
- **Predictable state**: State changes are explicit and immutable, improving traceability and testability.
- **Performance**: Fine-grained rebuilds via `BlocBuilder`/`BlocSelector` avoid unnecessary widget rebuilds.
- **Testability**: Cubit logic is plain Dart; you can unit test transitions without widget harnesses.
- **Scalability**: You can start simple with Cubit and scale up to full BLoC (events) if your feature grows in complexity.

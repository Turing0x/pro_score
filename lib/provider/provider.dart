import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_score/interface/interface.dart';

final gameHistoryProvider = StateNotifierProvider<GameHistoryNotifier, List<Game>>((ref) {
  return GameHistoryNotifier();
});

final currentGameProvider = StateNotifierProvider<CurrentGameNotifier, Game?>((ref) {
  return CurrentGameNotifier();
});

class GameHistoryNotifier extends StateNotifier<List<Game>> {
  GameHistoryNotifier() : super([]);

  void addGame(Game game) {
    state = [...state, game];
  }
}

class CurrentGameNotifier extends StateNotifier<Game?> {
  CurrentGameNotifier() : super(null);

  void startGame(List<Team> teams) {
    state = Game(teams: teams, date: DateTime.now());
  }

  void updateTeamPoints(String teamName, int newPoints) {
    if (state == null) return;

    final updatedTeams = state!.teams.map((team) {
      if (team.name == teamName) {
        team.updatePoints(newPoints);
      }
      return team;
    }).toList();

    state = Game(teams: updatedTeams, date: state!.date);
  }

  void endGame() {
    state = null;
  }
}

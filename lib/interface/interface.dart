class Team {
  final String name;
  int points;

  Team({required this.name, this.points = 0});

  void updatePoints(int newPoints) {
    points = newPoints;
  }
}

class Game {
  final List<Team> teams;
  final DateTime date;

  Game({required this.teams, required this.date});
}

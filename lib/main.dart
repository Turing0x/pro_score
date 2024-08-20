import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_score/interface/interface.dart';
import 'package:pro_score/provider/provider.dart';

void main() {
  runApp(const ProviderScope(child: ProScoreApp()));
}

class ProScoreApp extends StatelessWidget {
  const ProScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pro Score',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF222222),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const ProScoreScreen(),
    );
  }
}

class ProScoreScreen extends ConsumerStatefulWidget {
  const ProScoreScreen({super.key});

  @override
  ConsumerState<ProScoreScreen> createState() => _ProScoreScreenState();
}

class _ProScoreScreenState extends ConsumerState<ProScoreScreen> {

  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final currentGame = ref.watch(currentGameProvider);
    final gameHistory = ref.watch(gameHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pro Score'),
        backgroundColor: const Color(0xFF333333),
      ),
      body: Row(
        children: [
          // Main Content
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (currentGame == null) ...[
                    TextField(
                      controller: _teamAController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Nombre del primer equipo',
                        labelStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _teamBController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Nombre del segundo equipo',
                        labelStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final teamA = Team(name: _teamAController.text);
                        final teamB = Team(name: _teamBController.text);

                        if(teamA.name.isEmpty || teamB.name.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ambos equipos deben tener nombre')));
                          return;
                        }
                        ref.read(currentGameProvider.notifier).startGame([teamA, teamB]);

                        // Abre la nueva ventana con los puntajes
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ScoreDisplayScreen(),
                          ),
                        );
                      },
                      child: const Text('Iniciar Juego'),
                    ),
                  ] else ...[
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScoreCounter(
                              teamName: currentGame.teams[0].name,
                              points: currentGame.teams[0].points,
                              onIncrement1: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[0].name, currentGame.teams[0].points + 1);
                              },
                              onIncrement100: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[0].name, currentGame.teams[0].points + 100);
                              },
                              onIncrement500: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[0].name, currentGame.teams[0].points + 500);
                              },
                              onIncrement1000: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[0].name, currentGame.teams[0].points + 1000);
                              },
                              onDecrement1: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[0].name, currentGame.teams[0].points - 1);
                              },
                              onDecrement100: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[0].name, currentGame.teams[0].points - 100);
                              },
                              onDecrement500: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[0].name, currentGame.teams[0].points - 500);
                              },
                              onDecrement1000: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[0].name, currentGame.teams[0].points - 1000);
                              },
                            ),
                            const SizedBox(height: 20),
                            ScoreCounter(
                              teamName: currentGame.teams[1].name,
                              points: currentGame.teams[1].points,
                              onIncrement1: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[1].name, currentGame.teams[1].points + 1);
                              },
                              onIncrement100: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[1].name, currentGame.teams[1].points + 100);
                              },
                              onIncrement500: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[1].name, currentGame.teams[1].points + 500);
                              },
                              onIncrement1000: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[1].name, currentGame.teams[1].points + 1000);
                              },
                              onDecrement1: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[1].name, currentGame.teams[1].points - 1);
                              },
                              onDecrement100: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[1].name, currentGame.teams[1].points - 100);
                              },
                              onDecrement500: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[1].name, currentGame.teams[1].points - 500);
                              },
                              onDecrement1000: () {
                                ref.read(currentGameProvider.notifier).updateTeamPoints(currentGame.teams[1].name, currentGame.teams[1].points - 1000);
                              },
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                final currentGame = ref.read(currentGameProvider);
                                if (currentGame != null) {
                                  ref.read(gameHistoryProvider.notifier).addGame(currentGame);
                                  ref.read(currentGameProvider.notifier).endGame();
                                }
                              },
                              child: const Text('Finaliza Juego'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Sidebar for Game History
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF333333),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Historial de Juegos',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: gameHistory.length,
                      itemBuilder: (context, index) {
                        final game = gameHistory[index];
                        final date = game.date;
                        final teams = game.teams.map((team) => '${team.name} (${team.points})').join(' vs ');
                        final winner = game.teams.reduce((a, b) => a.points > b.points ? a : b).name;

                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(teams, style: const TextStyle(color: Colors.white)),
                              Text(winner, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          subtitle: Text('${date.day}/${date.month}/${date.year}', style: const TextStyle(color: Colors.white70)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Secondary Screen to Display Scores
class ScoreDisplayScreen extends ConsumerWidget {
  const ScoreDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(currentGameProvider);

    if (currentGame == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Score Display'),
        ),
        body: const Center(
          child: Text('No hay un juego en curso.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Display'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${currentGame.teams[0].name}: ${currentGame.teams[0].points}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            '${currentGame.teams[1].name}: ${currentGame.teams[1].points}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ScoreCounter extends StatelessWidget {
  final String teamName;
  final int points;
  final VoidCallback onIncrement1;
  final VoidCallback onIncrement100;
  final VoidCallback onIncrement500;
  final VoidCallback onIncrement1000;
  final VoidCallback onDecrement1;
  final VoidCallback onDecrement100;
  final VoidCallback onDecrement500;
  final VoidCallback onDecrement1000;

  const ScoreCounter({
    super.key,
    required this.teamName,
    required this.points,
    required this.onIncrement1,
    required this.onIncrement100,
    required this.onIncrement500,
    required this.onIncrement1000,
    required this.onDecrement1,
    required this.onDecrement100,
    required this.onDecrement500,
    required this.onDecrement1000,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(teamName, style: const TextStyle(fontSize: 24, color: Colors.white)),
        Text('$points', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: onDecrement1000,
              tooltip: '-1000',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: onDecrement500,
              tooltip: '-500',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: onDecrement100,
              tooltip: '-100',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: onDecrement1,
              tooltip: '-1',
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green),
              onPressed: onIncrement1,
              tooltip: '+1',
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green),
              onPressed: onIncrement100,
              tooltip: '+100',
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green),
              onPressed: onIncrement500,
              tooltip: '+500',
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green),
              onPressed: onIncrement1000,
              tooltip: '+1000',
            ),
          ],
        ),
      ],
    );
  }
}

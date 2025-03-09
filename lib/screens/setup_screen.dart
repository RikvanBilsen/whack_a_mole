import 'package:flutter/material.dart';
import 'create_game_screen.dart';
import 'join_game_screen.dart';
import '../style/appstyle.dart';

class GameSetupScreen extends StatelessWidget {
  const GameSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whack-a-Mole Setup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a role:',
              style: GameConstants.titleStyle,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateGameScreen(),
                  ),
                );
              },
              child: const Text('Create Game (Host)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinGameScreen(),
                  ),
                );
              },
              child: const Text('Join Game'),
            ),
          ],
        ),
      ),
    );
  }
}
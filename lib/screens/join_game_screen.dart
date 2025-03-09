import 'package:flutter/material.dart';
import 'game_screen.dart';
import '../services/firebase_service.dart';
import '../style/appstyle.dart';

class JoinGameScreen extends StatefulWidget {
  const JoinGameScreen({super.key});

  @override
  _JoinGameScreenState createState() => _JoinGameScreenState();
}

class _JoinGameScreenState extends State<JoinGameScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isJoining = false;
  String? _errorMessage;

  Future<void> _joinGame() async {
    setState(() {
      _isJoining = true;
      _errorMessage = null;
    });

    String gameCode = _codeController.text.trim().toUpperCase();
    
    try {
      bool gameExists = await _firebaseService.gameExists(gameCode);
      
      if (!gameExists) {
        setState(() {
          _isJoining = false;
          _errorMessage = GameConstants.gameNotFoundError;
        });
        return;
      }

      Map<dynamic, dynamic>? gameData = await _firebaseService.getGameData(gameCode);
      
      if (gameData == null) {
        setState(() {
          _isJoining = false;
          _errorMessage = GameConstants.gameNotFoundError;
        });
        return;
      }

      if (gameData['status'] != 'waiting') {
        setState(() {
          _isJoining = false;
          _errorMessage = GameConstants.gameStartedError;
        });
        return;
      }

      Map<dynamic, dynamic> devices = gameData['devices'] as Map<dynamic, dynamic>;
      String deviceId = 'Device${devices.length + 1}';

      await _firebaseService.joinGame(gameCode, deviceId);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameScreen(
            gameCode: gameCode,
            deviceId: deviceId,
            isHost: false,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _isJoining = false;
        _errorMessage = 'Error joining game: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Enter Game Code',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.games),
              ),
              textCapitalization: TextCapitalization.characters,
              maxLength: GameConstants.gameCodeLength,
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: _isJoining ? null : _joinGame,
              child: _isJoining
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Join Game'),
            ),
          ],
        ),
      ),
    );
  }
}
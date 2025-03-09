import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'game_screen.dart';
import '../services/firebase_service.dart';
import '../style/appstyle.dart';

class CreateGameScreen extends StatefulWidget {
  const CreateGameScreen({super.key});

  @override
  _CreateGameScreenState createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  late String _gameCode;
  final FirebaseService _firebaseService = FirebaseService();
  final List<String> _connectedDevices = [];
  static const String _hostDeviceId = 'Device1';

  @override
  void initState() {
    super.initState();
    _generateGameCode();
  }

  void _generateGameCode() {
    const uuid = Uuid();
    _gameCode = uuid.v4().substring(0, 6).toUpperCase();
    
    _setupGame();
  }

  Future<void> _setupGame() async {
    await _firebaseService.createGame(_gameCode, _hostDeviceId);

    _firebaseService.listenToNewDevices(_gameCode).listen((event) {
      if (event.snapshot.key != _hostDeviceId) {
        setState(() {
          _connectedDevices.add(event.snapshot.key!);
        });
      }
    });

    _firebaseService.listenToDeviceDisconnections(_gameCode).listen((event) {
      setState(() {
        _connectedDevices.remove(event.snapshot.key);
      });
    });
  }

  void _startGame() async {
    if (_connectedDevices.length < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(GameConstants.notEnoughDevicesError)),
      );
      return;
    }

    await _firebaseService.updateGameStatus(_gameCode, 'playing');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          gameCode: _gameCode,
          deviceId: _hostDeviceId,
          isHost: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Game'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Game Code:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                _gameCode,
                style: GameConstants.gameCodeStyle,
              ),
              const SizedBox(height: 30),
              const Text(
                'Connected Devices:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1. Device1 (Host - You)',
                        style: TextStyle(fontSize: 16),
                      ),
                      ..._connectedDevices.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${entry.key + 2}. ${entry.value}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: _connectedDevices.length >= 1 ? _startGame : null,
                child: const Text('Start Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
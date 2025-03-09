import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../style/appstyle.dart';

class GameScreen extends StatefulWidget {
  final String gameCode;
  final String deviceId;
  final bool isHost;

  const GameScreen({
    super.key,
    required this.gameCode,
    required this.deviceId,
    required this.isHost,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  bool _isGreen = false;
  int _score = 0;
  Timer? _gameTimer;
  final Random _random = Random();
  List<String> _deviceList = [];
  
  @override
  void initState() {
    super.initState();
    _setupGame();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _firebaseService.updatePlayerConnection(widget.gameCode, widget.deviceId, false);
    super.dispose();
  }

  Future<void> _setupGame() async {
    _firebaseService.listenToActiveDevice(widget.gameCode).listen((event) {
      int activeDevice = event.snapshot.value as int;
      int deviceNum = int.parse(widget.deviceId.replaceAll('Device', ''));
      
      setState(() {
        _isGreen = activeDevice == deviceNum;
      });
    });

    _firebaseService.listenToPlayerScore(widget.gameCode, widget.deviceId).listen((event) {
      setState(() {
        _score = (event.snapshot.value as int?) ?? 0;
      });
    });

    if (widget.isHost) {
      _deviceList = await _firebaseService.getGameDevices(widget.gameCode);
      
      _startGameLoop();
    }
  }

  void _startGameLoop() {
    _setRandomActiveDevice();
    
    _scheduleNextMole();
  }

  void _scheduleNextMole() {
    int delayMillis = 1000 + _random.nextInt(2000);
    
    _gameTimer = Timer(Duration(milliseconds: delayMillis), () {
      _setRandomActiveDevice();
      _scheduleNextMole();
    });
  }

  void _setRandomActiveDevice() {
    if (widget.isHost && _deviceList.isNotEmpty) {
      int randomDeviceNum = _random.nextInt(_deviceList.length) + 1;
      _firebaseService.updateActiveDevice(widget.gameCode, randomDeviceNum);
    }
  }

  void _handleTap() {
    if (_isGreen) {
      _firebaseService.listenToPlayerScore(widget.gameCode, widget.deviceId).first.then((event) {
        int currentScore = (event.snapshot.value as int?) ?? 0;
        _firebaseService.updatePlayerScore(widget.gameCode, widget.deviceId, currentScore + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _handleTap,
        child: Container(
          color: _isGreen ? GameConstants.activeColor : GameConstants.inactiveColor,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Score: $_score',
                        style: GameConstants.scoreStyle,
                      ),
                      Text(
                        widget.deviceId,
                        style: GameConstants.deviceIdStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      _isGreen ? 'click' : 'wait',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _isGreen ? 48 : 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
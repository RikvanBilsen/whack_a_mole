import 'package:flutter/material.dart';

class GameConstants {
  static const int minDevicesRequired = 2;
  static const int gameCodeLength = 6;
  
  static const Color activeColor = Colors.green;
  static const Color inactiveColor = Colors.red;
  
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle scoreStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle deviceIdStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
  
  static const TextStyle gameCodeStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );
  
  static const String gameNotFoundError = 'Game not found';
  static const String gameStartedError = 'Game already started';
  static const String notEnoughDevicesError = 'Need at least 2 players';
}

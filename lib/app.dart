import 'package:flutter/material.dart';
import 'screens/setup_screen.dart';

class WhacAMoleApp extends StatelessWidget {
  const WhacAMoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whack-a-Mole',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameSetupScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'services/firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    if (Firebase.apps.isEmpty) {
      print('Initializing Firebase');
      await Firebase.initializeApp(
        name: 'Whack-a-mole-db',
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('Firebase successfully initialized!');
    } else {
      print('Firebase was already initialized');
    }
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  
  runApp(const WhacAMoleApp());
}

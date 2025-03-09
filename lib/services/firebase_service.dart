import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  final _database = FirebaseDatabase.instance.ref();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  Future<void> createGame(String gameCode, String hostDeviceId) async {
    await _database.child('games').child(gameCode).set({
      'status': 'waiting',
      'host': hostDeviceId,
      'activeDevice': 0,
      'devices': {
        hostDeviceId: {
          'connected': true,
          'score': 0,
          'isHost': true,
        }
      }
    });
  }

  Future<void> joinGame(String gameCode, String deviceId) async {
    await _database.child('games').child(gameCode).child('devices').child(deviceId).set({
      'connected': true,
      'score': 0,
      'isHost': false,
    });
  }

  Future<void> updateGameStatus(String gameCode, String status) async {
    await _database.child('games').child(gameCode).update({
      'status': status,
      'timestamp': ServerValue.timestamp,
    });
  }

  Future<void> updateActiveDevice(String gameCode, int deviceNum) async {
    await _database.child('games').child(gameCode).update({
      'activeDevice': deviceNum
    });
  }

  Future<void> updatePlayerScore(String gameCode, String deviceId, int score) async {
    await _database.child('games').child(gameCode).child('devices')
        .child(deviceId).update({
      'score': score
    });
  }

  Future<void> updatePlayerConnection(String gameCode, String deviceId, bool connected) async {
    await _database.child('games').child(gameCode).child('devices')
        .child(deviceId).update({
      'connected': connected
    });
  }

  Future<bool> gameExists(String gameCode) async {
    DataSnapshot snapshot = await _database.child('games').child(gameCode).get();
    return snapshot.exists;
  }

  Future<Map<dynamic, dynamic>?> getGameData(String gameCode) async {
    DataSnapshot snapshot = await _database.child('games').child(gameCode).get();
    if (snapshot.exists) {
      return snapshot.value as Map<dynamic, dynamic>;
    }
    return null;
  }

  Stream<DatabaseEvent> listenToGameStatus(String gameCode) {
    return _database.child('games').child(gameCode).child('status').onValue;
  }

  Stream<DatabaseEvent> listenToActiveDevice(String gameCode) {
    return _database.child('games').child(gameCode).child('activeDevice').onValue;
  }

  Stream<DatabaseEvent> listenToPlayerScore(String gameCode, String deviceId) {
    return _database.child('games').child(gameCode).child('devices')
        .child(deviceId).child('score').onValue;
  }

  Stream<DatabaseEvent> listenToNewDevices(String gameCode) {
    return _database.child('games').child(gameCode).child('devices').onChildAdded;
  }

  Stream<DatabaseEvent> listenToDeviceDisconnections(String gameCode) {
    return _database.child('games').child(gameCode).child('devices').onChildRemoved;
  }

  Future<List<String>> getGameDevices(String gameCode) async {
    DataSnapshot snapshot = await _database.child('games').child(gameCode)
        .child('devices').get();
    
    if (snapshot.exists) {
      Map<dynamic, dynamic> devices = snapshot.value as Map<dynamic, dynamic>;
      return devices.keys.toList().cast<String>();
    }
    return [];
  }
}
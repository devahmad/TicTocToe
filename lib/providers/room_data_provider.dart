import 'package:flutter/material.dart';

import '../models/player.dart';
import '../resources/socket_methods.dart';



class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomdata = {};

  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];

  // We cannot use length of displayElements variable since its already filled with empty string by default.
  // So we will keep track of how many grids are filled using _filledBoxes state
  int _filledBoxes = 0;

  bool _absorbingValue = true; // New CODE

  bool get absorbingValue => _absorbingValue; // New CODE

  Player _player1 =
      Player(playername: '', socketID: '', points: 0, playerType: 'X');
  Player _player2 =
      Player(playername: '', socketID: '', points: 0, playerType: 'O');

  Player get player1 => _player1;
  Player get player2 => _player2;

  Map<String, dynamic> get roomData => _roomdata;

  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;

  void updateRoomData(Map<String, dynamic> data) {
    _roomdata = data;
    _absorbingValue = _roomdata['turn']['socketID'] !=
        SocketMethods().socketClient.id; // New CODE
    notifyListeners();
  }

  void updateAbsorbingToTrue() {
    // New CODE
    _absorbingValue = true;
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElements[index] = choice; // X or O
    _filledBoxes += 1;
    notifyListeners();
  }

  void setFilledBoxesTo0() {
    _filledBoxes = 0; // After the round ends, we can play again.
  }
}

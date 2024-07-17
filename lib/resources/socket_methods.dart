import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../providers/room_data_provider.dart';
import '../screens/game_screen.dart';
import '../utils/utils.dart';
import './socket_client.dart';
import 'game_methods.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;

  void createRoom(String playername) {
    if (playername.isNotEmpty) {
      // Emit an event so that server can listen to it.
      _socketClient.emit("createRoom", {'playername': playername});
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on("createRoomSuccess", (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.of(context).pushNamed(GameScreen.routeName);
    });
  }

  void joinRoom(String playername, String roomId) {
    if (playername.isNotEmpty && roomId.isNotEmpty) {
      _socketClient
          .emit("joinRoom", {'playername': playername, 'roomId': roomId});
    }
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.of(context).pushNamed(GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on("errorOccured", (data) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
    });
  }

  void updatePlayerStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      // here playerData is an array of player map
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    // displayElements will keep track of all the 9 grid values i.e ['X','O','O,''. . . .]
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {'index': index, 'roomId': roomId});
    }
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);

      roomDataProvider.updateRoomData(data['room']);
      roomDataProvider.updateDisplayElements(data['index'], data['choice']);

      // Check for winner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on("pointIncrease", (playerData) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialog(context, "${playerData['playername']} won the game !");
      Navigator.popUntil(context, (route) => false);
    });
  }
}

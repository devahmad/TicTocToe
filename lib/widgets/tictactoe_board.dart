import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/room_data_provider.dart';
import '../resources/socket_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: AbsorbPointer(
        // if true then cannot click. if false then its clickable.
        // absorbing: roomDataProvider.roomData['turn']['socketID'] !=
        //     _socketMethods.socketClient.id,
        absorbing: roomDataProvider.absorbingValue,
        child: GridView.builder(
            itemCount: 9, // since it is a 3 x 3 board
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  if (roomDataProvider.absorbingValue) {
                    return;
                  }
                  roomDataProvider.updateAbsorbingToTrue();
                  _socketMethods.tapGrid(
                      index,
                      roomDataProvider.roomData['_id'],
                      roomDataProvider.displayElements);
                },
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white24)),
                  child: Center(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        roomDataProvider.displayElements[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 100,
                            shadows: [
                              Shadow(
                                  blurRadius: 40,
                                  color:
                                      roomDataProvider.displayElements[index] ==
                                              "O"
                                          ? Colors.blue
                                          : Colors.red)
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

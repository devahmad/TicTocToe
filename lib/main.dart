import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictoctoe/providers/room_data_provider.dart';
import 'package:tictoctoe/screens/game_screen.dart';
import 'package:tictoctoe/screens/main_menu_screen.dart';

import 'screens/create_room_screen.dart';
import 'screens/join_room_screen.dart';
import 'utils/colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'TicTacToe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routeName:(context) => const MainMenuScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}

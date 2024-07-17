import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import 'create_room_screen.dart';
import 'join_room_screen.dart';


class MainMenuScreen extends StatelessWidget {
  static String routeName = "/main-menu";
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                onTap: () {
                  Navigator.of(context).pushNamed(CreateRoomScreen.routeName);
                },
                text: "Create Room"),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onTap: () {
                  Navigator.of(context).pushNamed(JoinRoomScreen.routeName);
                },
                text: "Join Room")
          ],
        ),
      ),
    ));
  }
}

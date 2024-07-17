import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/room_data_provider.dart';
import 'custom_textfield.dart';


class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController roomIdController;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
        text: Provider.of<RoomDataProvider>(context, listen: false)
            .roomData['_id']);
  }

  @override
  void dispose() {
    roomIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.white,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text("Waiting for another player to join"),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: roomIdController,
            hintText: "",
            isReadOnly: true,
          )
        ],
      ),
    );
  }
}

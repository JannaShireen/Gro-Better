import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class InitCall extends StatelessWidget {
  final String id;
  final String name;
  const InitCall({required this.id, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('printing id and name $id name: $name');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'You are about to start the session. Are you ready?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              ZegoSendCallInvitationButton(
                isVideoCall: true,
                //iconSize: const Size(26, 25),
                resourceID: "zegouikit_call", // For offline call notification
                invitees: [
                  ZegoUIKitUser(
                    id: id,
                    name: name,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

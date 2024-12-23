import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lets_meet/resources/jitsi_meet.dart';
import 'package:lets_meet/screens/join_screen.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  Future<void> createNewMeeting() async {
    String roomName = generateRoomName();
    _jitsiMeetMethods.createMeeting(roomName);
  }

  String generateRoomName() {
    var random = Random();
    return (random.nextInt(10000000) + 10000000).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo.png',
                height: 80,
              ),
              const SizedBox(height: 40),

              // Title
              const Text(
                "CREATE / JOIN MEETINGS",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: createNewMeeting,
                    icon: const Icon(
                      Icons.videocam,
                      size: 30,
                    ),
                    label: const Text(
                      'Create Meeting',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      textStyle: const TextStyle(fontSize: 18),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 30.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const JoinMeetingScreen();
                      }));
                    },
                    icon: const Icon(
                      Icons.add_box_rounded,
                      size: 30,
                    ),
                    label: const Text(
                      'Join Meeting',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.greenAccent,
                      textStyle: const TextStyle(fontSize: 18),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 30.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
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

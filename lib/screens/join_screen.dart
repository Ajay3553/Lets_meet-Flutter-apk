import 'package:flutter/material.dart';
import 'package:lets_meet/resources/MeetingRep.dart';
import 'package:lets_meet/resources/auth_methods.dart';

class JoinMeetingScreen extends StatefulWidget {
  const JoinMeetingScreen({super.key});

  @override
  State<JoinMeetingScreen> createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  bool audioSelected = true;
  bool videoSelected = true;
  final _authMethods = AuthMethods();
  late final TextEditingController idController;
  late final TextEditingController nameController;
  final MeetingRepositoryImplementation meetingRepositoryImplementation =
      MeetingRepositoryImplementation();

  @override
  void initState() {
    idController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    super.dispose();
  }

  joinMeeting() {
    meetingRepositoryImplementation.createMeeting(
      idController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Meeting ID',
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.black54),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromRGBO(45, 101, 246, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: joinMeeting,
              child: const Text(
                'Join',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            SwitchListTile.adaptive(
              tileColor: Colors.grey.shade200,
              activeColor: Colors.blue.shade700,
              title: const Text(
                'Don\'t Connect To Audio',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              value: audioSelected,
              onChanged: (bool? value) {
                setState(() {
                  audioSelected = value!;
                });
              },
            ),
            const Divider(height: 1.0, color: Colors.grey),
            SwitchListTile(
              tileColor: Colors.grey.shade200,
              activeColor: Colors.blue.shade700,
              title: const Text(
                'Turn Off My Video',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              value: videoSelected,
              onChanged: (bool? value) {
                setState(() {
                  videoSelected = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

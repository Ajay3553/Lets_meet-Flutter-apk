import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:lets_meet/resources/auth_methods.dart';
import 'package:lets_meet/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeet jitsiMeet = JitsiMeet();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void createMeeting(
    String roomName,
  ) async {
    try {
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        serverURL: 'https://meet.engagemedia.org',
        configOverrides: {
          "startWithAudioMuted": true,
          "startWithVideoMuted": true,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: _authMethods.user.displayName,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );
      _firestoreMethods.addMeetingHistory(roomName);
      await jitsiMeet.join(options);
    } catch (e) {
      print("Error starting meeting: $e");
      throw e;
    }
  }
}

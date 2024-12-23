import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:lets_meet/resources/auth_methods.dart';

class MeetingRepositoryImplementation implements MeetingRepository {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeet jitsiMeet = JitsiMeet();

  @override
  Future<void> createMeeting(String roomName) async {
    try {
      var options = JitsiMeetConferenceOptions(
        room: roomName,
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
      await jitsiMeet.join(options);
    } catch (e) {
      print("Error starting meeting: $e");
      throw e;
    }
  }
}

class MeetingRepository {
  void createMeeting(String roomName) {}
}

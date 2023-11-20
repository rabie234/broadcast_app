

import 'package:get/get.dart';
import 'package:videosdk/videosdk.dart';

abstract class MeetingController extends GetxController {
toggleMic();
 toogleCam();
setMeetingEventListener();
onWillPop();
createRoom(meetingId,token);
  leave();
}





class MeetingControllerImp extends MeetingController { 
late Room room;
   Map<String, Participant> participants = {};
   bool micEnabled = true;
   bool camEnabled = true;

@override
toggleMic() {
  micEnabled ? room.muteMic() : room.unmuteMic();
  micEnabled  =! micEnabled;
print(micEnabled);
  update();
  }
@override
  toogleCam(){
     camEnabled ? room.disableCam() : room.enableCam();
    camEnabled = ! camEnabled;
    update();
  }
   
   @override
createRoom(meetingId,token){
     room = VideoSDK.createRoom(
      roomId: meetingId,
      token: token,
      displayName: "John Doe",
      defaultCameraIndex: 1);
    room.join();
    
      setMeetingEventListener();
      print('eeeee');
}

@override

  void setMeetingEventListener() {
    room.on(Events.roomJoined, () {
    
        participants.putIfAbsent(
            room.localParticipant.id, () => room.localParticipant);
   update();
    });

    room.on(
      Events.participantJoined,
      (Participant participant) {
 
          () => participants.putIfAbsent(participant.id, () => participant);
    update();
      },
    );

    room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
   
          () => participants.remove(participantId);
   update();
      }
    });

    room.on(Events.roomLeft, () {
      participants.clear();
      Get.back();
    });
  }
@override
  Future<bool> onWillPop() async {
   

    room.leave();
    return true;
  }

  @override 
  leave(){
       room.leave();
  }
 

}

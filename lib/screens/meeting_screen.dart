import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_new_app/services/api.dart';
import 'package:live_new_app/controller/meetingController.dart';
import 'package:videosdk/videosdk.dart';
import 'package:wakelock/wakelock.dart';
import '../widgets/participant_tile.dart';
import '../widgets/meeting_controls.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  
MeetingControllerImp meetingcontroller = Get.put(MeetingControllerImp());
        void _showAlertDialog(BuildContext context) {
              if (kDebugMode) {
                    print("______________________________________________________________");
                    print(meetingcontroller.participants.length);
                     print("______________________________________________________________");
                  }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert Dialog"),
          content: Text(widget.meetingId),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
   
  Wakelock.enable();
meetingcontroller.createRoom(widget.meetingId, token);

//     // Join room

    super.initState();
  }

  // listening to meeting events


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return 
    
    GetBuilder<MeetingControllerImp>(builder: (meetingcontroller){
      return WillPopScope(
      onWillPop: () => meetingcontroller.onWillPop(),
      child: Scaffold(
      
        body: Stack(
          children: [
            Text(widget.meetingId),
            //render all participant
            Container(
              width: double.infinity,
              height: double.infinity,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  // crossAxisSpacing: 0,
                  // mainAxisSpacing: 0,
                  childAspectRatio: 1/1
                  ,
                ),
                itemBuilder: (context, index) {
                  if (kDebugMode) {
                    print("______________________________________________________________");
                    print(meetingcontroller.participants.length);
                     print("______________________________________________________________");
                  }
                  return ParticipantTile(
                    key: Key(meetingcontroller.participants.values.elementAt(1).id),
                      participant: meetingcontroller.participants.values.elementAt(1));
                },
                itemCount: meetingcontroller.participants.length,
              ),
            ),
            Positioned(  bottom: 100,right: 0, child: 
            ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(height: 200,width: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Color.fromARGB(90, 0, 0, 0),width: 2)),child:meetingcontroller.participants.isEmpty?Text("isloading..."): ParticipantTile(
                      key: Key(meetingcontroller.participants.values.elementAt(0).id),
                        participant: meetingcontroller.participants.values.elementAt(0)), ),
            ) ),
             Positioned(top: 0,left: 0,right: 0, child: Container(height: 70,padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),alignment: Alignment.bottomCenter,color: Color.fromARGB(90, 0, 0, 0),
             
             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("time : 0.0s",style: TextStyle(color: Colors.white),) ,InkWell(onTap: () {
        _showAlertDialog(context);
             }, child: Icon(Icons.info_outline,color: Colors.white,))]),
             )
             
             ),
             const Positioned(bottom: 0,left: 0,right: 0, child:  SizedBox(
             
                child: 
                
                  MeetingControls(),
              )
                ),
        
          ],
        ),
      ),
      // child: JoinScreen(),
    );
    });
  }
}
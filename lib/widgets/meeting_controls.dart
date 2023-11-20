import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:live_new_app/controller/meetingController.dart';

class MeetingControls extends StatelessWidget {


   const MeetingControls(
      {super.key,});


  @override
  Widget build(BuildContext context) {

    return
    GetBuilder<MeetingControllerImp>(builder: (meetingcontroller){
      return
     Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color.fromARGB(90, 0, 0, 0)),
       child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          GestureDetector(
            
              onTap:()=> meetingcontroller.toggleMic(), 
              child: Container( padding: EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color:meetingcontroller.micEnabled? Color.fromARGB(255, 31, 134, 35): Color.fromARGB(255, 216, 209, 209)),
              child:  Icon(meetingcontroller.micEnabled? Icons.mic:Icons.mic_external_off,color: Colors.white,)),),
                  GestureDetector(
          
              onTap:()=> meetingcontroller.leave(), child: Container( padding: EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.redAccent),
                 child: const Icon(Icons.phone)),),
          GestureDetector(
              onTap:()=> meetingcontroller.toogleCam(),
              
              child: Container( padding: EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color:meetingcontroller.camEnabled? Color.fromARGB(255, 31, 134, 35): Color.fromARGB(255, 216, 209, 209)),
                 child: Icon (Icons.camera_alt,color: Colors.white,),)),
        ],
         ),
     );

    });
  }
}
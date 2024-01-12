import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_auth/screens/otp_screen.dart';

class Backend{
  static Future verifyPhoneNumber({required String phoneNumber, required bool isSignUp, required String type, List<String>? userdata}) async{
   try{
     await FirebaseAuth.instance.verifyPhoneNumber(
         verificationCompleted: (PhoneAuthCredential credential){},
         verificationFailed: (FirebaseAuthException e){
           Get.snackbar("Error occured", e.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
         },
         codeSent: (String verficationID, int? resendToken){
           print("Code sent");
           Get.off(OTPScreen(verficationID: verficationID,PhoneNumber: phoneNumber, isSignUp: isSignUp, type: type, userdata: userdata,));
         },
         codeAutoRetrievalTimeout: (String verification){},
         phoneNumber: phoneNumber
     );
   } catch(e){
     Get.snackbar('backend Exception', e.toString());
   }
  }
}

// void otpFunction({required final email,required final name, required final phoneNumber}) async {
//   await FirebaseAuth.instance.verifyPhoneNumber(
//     phoneNumber: countrycode.text + phone,
//     verificationCompleted: (PhoneAuthCredential credential) {},
//     verificationFailed: (FirebaseAuthException e) {
//       snakbar.showErrorSnackbar(context, e.toString());
//       print("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"+e.toString()); },
//     codeSent: (String verificationId, int? resendToken) {
//       SignUp.verify = verificationId;
//       print("HSHSHSHSHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHS");
//       print("Verification id is initilized = ${SignUp.verify}");
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => OtpPage(verify: SignUp.verify, email: email, name: name, phoneNumber: phoneNumber,isSignUP: true,)));
//     },
//     codeAutoRetrievalTimeout: (String verificationId) {},
//   );
//   // Navigator.pushNamed(context, 'otp');
// }
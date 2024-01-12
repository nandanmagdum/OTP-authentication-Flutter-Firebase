import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homescreen.dart';
class OTPScreen extends StatefulWidget {
  final String verficationID;
  final List<String>? userdata;
  final String PhoneNumber;
  final bool isSignUp;
  final String type;
  const OTPScreen({super.key, this.userdata,required this.verficationID,required this.PhoneNumber,required this.isSignUp, required this.type});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter OTP"),centerTitle: true,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.type}", style: TextStyle(fontSize: Get.width*0.05, fontWeight: FontWeight.bold),),
              TextFormField(
                controller: otp,
                onChanged: (value){
                  otp.text = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter OTP here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              ElevatedButton(onPressed: () async{
                setState(() {
                  isLoading = true;
                });
                try{
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verficationID,
                      smsCode: otp.text
                  );
                  await FirebaseAuth.instance.signInWithCredential(credential).then((value) async{
                    if(widget.isSignUp == true) {
                      await FirebaseFirestore.instance.collection('users').doc(widget.PhoneNumber).set({
                        'name': widget.userdata![0],
                        'email': widget.userdata![1],
                        'address': widget.userdata![2],
                        'phone': widget.PhoneNumber,
                      });
                    }
                    Get.off(HomeScreen());
                  });
                }catch(e){
                  Get.snackbar("Erorrr", e.toString());
                }
                setState(() {
                  isLoading = false;
                });
              }, child: Container(
                  padding: EdgeInsets.all(20),
                  width: Get.width,
                  height: Get.height*0.08,
                  child: (isLoading) ? Center(child: CircularProgressIndicator(),): Center(child: Text("Verify")))),
            ],
          ),
        ),
      ),
    );
  }
}

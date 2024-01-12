import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_auth/firebase/checkUser.dart';
import 'package:otp_auth/screens/get_details.dart';
import 'package:otp_auth/screens/otp_screen.dart';

import '../firebase/otp_service.dart';
class EnterPhone extends StatefulWidget {
  const EnterPhone({super.key});

  @override
  State<EnterPhone> createState() => _EnterPhoneState();
}

class _EnterPhoneState extends State<EnterPhone> {
  bool isLoading = false;
  PhoneNumber phoneNumber = PhoneNumber(dialCode: '+91');
  @override
  void initState() {
    isLoading = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter phone number"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             InternationalPhoneNumberInput(
               initialValue: PhoneNumber(isoCode: 'IN'),
                 onInputChanged: (PhoneNumber phonerNumber){
                    phoneNumber = phonerNumber;
                    print(phonerNumber);
             }),
            SizedBox(
              height: Get.height*0.02,
            ),
            ElevatedButton(onPressed: () async{
              setState(() {
                isLoading = true;
              });
              try{
                if(await CheckIfUserExists.check(phoneNumber.phoneNumber.toString()))
                  {
                    Backend.verifyPhoneNumber(phoneNumber: phoneNumber.phoneNumber.toString(), isSignUp: false, type: "Login");
                  }
                else {
                  Get.to(GetDetails(phoneNumber: phoneNumber.phoneNumber.toString()));
                }
              }catch(e){
                Get.snackbar('Enter Phone Error', e.toString());
              }
              setState(() {
                isLoading = false;
              });
            }, child: Container(
              padding: EdgeInsets.all(20),
              width: Get.width,
              height: Get.height*0.08,
              child: Center(child: (isLoading) ? CircularProgressIndicator(): Text("Continue", style: TextStyle(fontSize: Get.width*0.04),)))),
          ],
        ),
      ),
    );
  }
}

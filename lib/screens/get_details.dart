import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_auth/common_widgets/widgets.dart';
import 'package:otp_auth/screens/otp_screen.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../firebase/otp_service.dart';

class GetDetails extends StatefulWidget {
  final String phoneNumber;
  const GetDetails({super.key, required this.phoneNumber});

  @override
  State<GetDetails> createState() => _GetDetailsState();
}

class _GetDetailsState extends State<GetDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter you details")),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                widget.phoneNumber,
                style: TextStyle(
                    fontSize: Get.width * 0.05, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Widgets.textEditingController(
                  textEditingController: name, hintText: 'Enter Name'),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Widgets.textEditingController(
                  textEditingController: email, hintText: 'Enter Email'),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Widgets.textEditingController(
                  textEditingController: address, hintText: 'Enter Address'),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await Backend.verifyPhoneNumber(
                        phoneNumber: widget.phoneNumber,
                        isSignUp: true,
                        type: "SignUp",
                        userdata: [name.text, email.text, widget.phoneNumber]
                    );
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                  padding: EdgeInsets.all(20),
                  width: Get.width,
                  height: Get.height*0.08,
                  child: (isLoading) ? Center(child: CircularProgressIndicator(),): Text("Get OTP"))),
            ],
          ),
        ),
      )),
    );
  }
}

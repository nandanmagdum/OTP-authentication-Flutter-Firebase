import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_auth/screens/enter_phone.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomeScreen"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome ${FirebaseAuth.instance.currentUser!.phoneNumber} \nyour id is ${FirebaseAuth.instance.currentUser!.uid}"),
            ElevatedButton(onPressed: (){
              setState(() {
                isLoading = true;
              });
              try{
                FirebaseAuth.instance.signOut().then((value) {
                  Get.offAll(EnterPhone());
                });
              } catch(e){
                Get.snackbar('Signout error', e.toString());
              }
            }, child: (isLoading) ? Center(child: CircularProgressIndicator(),): Text("Logout")),
          ],
        ),
      ),
    );
  }
}

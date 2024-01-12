import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckIfUserExists {
  static Future<bool> check(String phoneNumber) async{
    final doc = await FirebaseFirestore.instance.collection('users').doc(phoneNumber).get();
    if(doc.exists) return true;
    return false;
  }
}
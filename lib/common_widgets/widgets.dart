import 'package:flutter/material.dart';

class Widgets {
  static TextFormField textEditingController({required TextEditingController textEditingController, required String hintText}) => TextFormField(
      controller: textEditingController,
    onChanged: (value){
        textEditingController.text = value;
    },
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
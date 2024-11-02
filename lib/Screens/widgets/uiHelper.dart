import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper {
  static CustomTextField(TextEditingController controller,String text){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
      child: TextField(
        controller: controller,
        decoration:  InputDecoration(
          hintText: text,
              border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)
        )
        ),
      ),
    );
  }
}
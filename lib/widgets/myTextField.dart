import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  MyTextField(this.controller, this.hintText);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(80)),
        isDense: true,
        fillColor: Colors.blue[200],
        filled: true,
        contentPadding: EdgeInsets.all(12),
        hintStyle: TextStyle(fontSize: 18, color: Colors.white),
        hintText: hintText,
      ),
    );
  }
}

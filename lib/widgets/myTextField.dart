import 'package:flutter/material.dart';

Widget myTextField(TextEditingController controller,String hintText){
  return TextField(
    controller: controller,
    style: TextStyle(fontSize: 18, color: Colors.white),
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(80)),
      isDense: true,
      fillColor: Colors.white10,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      hintStyle: TextStyle(fontSize: 18, color: Colors.white54),
      hintText: hintText,
    ),
  );
}

Widget myFlatButton({onPressed, String content}){
  return FlatButton(
    minWidth: 200,
    height: 42,
    child: Text(content, style: TextStyle(color: Colors.white, fontSize: 18),),
    onPressed: onPressed,
    color: Colors.lightBlue[700],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
  );
}
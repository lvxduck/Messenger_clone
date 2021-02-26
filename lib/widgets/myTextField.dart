import 'package:flutter/material.dart';

Widget myTextField(TextEditingController controller,String hintText, bool isDarkMode){
  return TextField(
    controller: controller,
    style: TextStyle(fontSize: 18, color: isDarkMode?Colors.white:Colors.black),
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(80)),
      isDense: true,
      fillColor: isDarkMode?Colors.white10:Colors.black12,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      hintStyle: TextStyle(fontSize: 18, color: isDarkMode?Colors.white54:Colors.black54),
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
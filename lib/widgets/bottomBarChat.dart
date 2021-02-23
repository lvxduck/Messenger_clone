import 'package:flutter/material.dart';

class BottomBarChat extends StatelessWidget {
  final onSubmit;
  final isDarkMode;

  BottomBarChat({this.onSubmit, this.controller, this.isDarkMode});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: EdgeInsets.only(left: 4, top: 8, bottom: 8),
      margin: EdgeInsets.only(top: 8),
      color: isDarkMode ? Colors.black87 : Colors.white,
      child: Row(
        children: [
          // Container(color: Colors.transparent, child: myIconButton(Icons.camera_alt_rounded, () => {print("camera")})),
          // Container(color: Colors.transparent, child: myIconButton(Icons.photo_library_rounded, () => {})),
          // Container(color: Colors.transparent, child: myIconButton(Icons.keyboard_voice_rounded, () => {})),
          IconButton(
            icon: Icon(Icons.camera_alt_rounded, color: isDarkMode?Colors.white:Colors.black,),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.photo_library_rounded, color: isDarkMode?Colors.white:Colors.black,),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.keyboard_voice_rounded, color: isDarkMode?Colors.white:Colors.black,),
            onPressed: () {},
          ),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(30)),
                      fillColor: isDarkMode?Colors.white10:Colors.black12,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 10),
                      hintStyle: TextStyle(fontSize: 18,color: isDarkMode?Colors.white:Colors.black),
                      hintText: "Aa",
                    ),
                    style: TextStyle(color: isDarkMode?Colors.white:Colors.black),
                    onSubmitted: onSubmit),
                Container(
                  padding: EdgeInsets.only(right: 6),
                  child: GestureDetector(
                      child: Icon(
                    Icons.insert_emoticon_rounded,
                    color: isDarkMode?Colors.white:Colors.black,
                    size: 24,
                  )),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: isDarkMode?Colors.white:Colors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget myIconButton(IconData icon, onPressed) {
    return ButtonTheme(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      height: 0,
      buttonColor: Colors.transparent,
      child: RaisedButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ), //your original button
    );
  }
}

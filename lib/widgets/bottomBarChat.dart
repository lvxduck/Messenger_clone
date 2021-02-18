import 'package:flutter/material.dart';

class BottomBarChat extends StatelessWidget {
  final onSubmit;

  BottomBarChat({this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.all(4),
      color: Colors.black87,
      child: Row(
        children: [
          myIconButton(Icons.camera_alt_rounded,()=>{

          }),
          myIconButton(Icons.photo_library_rounded,()=>{

          }),
          myIconButton(Icons.keyboard_voice_rounded,()=>{

          }),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.white30,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 10),
                      hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                      hintText: "Aa",
                    ),
                    style: TextStyle(color: Colors.white),
                    onSubmitted: onSubmit),
                Container(
                  padding: EdgeInsets.only(right: 4),
                  child: GestureDetector(
                      child: Icon(Icons.insert_emoticon_rounded,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
          myIconButton(Icons.send,()=>{

          }),
        ],
      ),
    );
  }

  Widget myIconButton(IconData icon, onPressed){
    return  ButtonTheme(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      height: 0,
      buttonColor: Colors.transparent,
      child: RaisedButton(
        onPressed: onPressed,
        child:  Icon(
          icon,
          color: Colors.white,
        ),), //your original button
    );
  }
}

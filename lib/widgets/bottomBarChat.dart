import 'package:flutter/material.dart';

class BottomBarChat extends StatelessWidget {

  final onSubmit;

  BottomBarChat({this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(4),
      color: Colors.green,
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.camera_alt_rounded, color: Colors.white,), onPressed: null),
          IconButton(icon: Icon(Icons.photo_library_rounded, color: Colors.white,), onPressed: null),
          IconButton(icon: Icon(Icons.keyboard_voice_rounded, color: Colors.white,), onPressed: null),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(80)),
                    fillColor: Colors.blue[200],
                    filled: true,
                    contentPadding: EdgeInsets.all(12),
                    hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                    hintText: "HintText",
                  ),
                  onSubmitted: onSubmit
                ),
                IconButton(icon: Icon(Icons.insert_emoticon_rounded, color: Colors.white,), onPressed: null),
              ],
            ),
          )
        ],
      ),
    );
  }
}

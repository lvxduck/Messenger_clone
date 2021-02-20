import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quickmessage/models/room.dart';
import 'package:intl/intl.dart';

Widget itemUserChat({Room room, onClick}) {
  String name = room.name;
  String urlPicture = room.urlPicture;
  String recentMessage = room.messages.length == 0 ? "" : room.messages[room.messages.length - 1].content;
  String time = room.messages.length == 0
      ? ""
      : DateFormat.jm().format(DateTime.fromMicrosecondsSinceEpoch(room.messages[room.messages.length - 1].time));

  return FlatButton(
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    onPressed: onClick,
    splashColor: Colors.white10,
    child: Container(
      height: 60,
      padding: EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(urlPicture),
            backgroundColor: Colors.red,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          recentMessage + "   ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      Text(
                        time + "    ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// class ItemUserChat extends StatelessWidget {
//   final String name;
//   final String urlPicture;
//   final String recentMessage;
//   final onClick;
//
//   ItemUserChat(
//       {this.name = 'Le Vinh Nhan Duc',
//       // this.urlPicture = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU53EcOIyxE7pOZJBvGHJGbDk39EYxvOhbdw&usqp=CAUhttps://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70",
//       this.urlPicture =
//           "https://firebasestorage.googleapis.com/v0/b/quickmessage-9e7be.appspot.com/o/image_profile%2Fpexels-photo-415829.jpeg?alt=media&token=034769d7-64ba-49e8-8d29-6f36219f5354",
//       this.recentMessage = "Hello",
//       this.onClick});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onClick,
//       child: Container(
//         height: 60,
//         padding: EdgeInsets.only(top: 4),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             CircleAvatar(
//               radius: 30,
//               backgroundImage: NetworkImage(urlPicture),
//               backgroundColor: Colors.red,
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.only(left: 14),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                     Text(
//                       recentMessage,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

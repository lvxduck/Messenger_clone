import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ItemUserChat extends StatelessWidget {
  final String name;
  final String urlPicture;
  final String recentMessage;
  final onClick;

  ItemUserChat({
    this.name = 'Le Vinh Nhan Duc',
    this.urlPicture = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU53EcOIyxE7pOZJBvGHJGbDk39EYxvOhbdw&usqp=CAUhttps://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70",
    this.recentMessage = "Hello",
    this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 60,
        padding: EdgeInsets.only(top: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
              NetworkImage(urlPicture),
              backgroundColor: Colors.red,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(name, style: TextStyle(fontSize: 18),),
                    Text(recentMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

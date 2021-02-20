import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/homeController.dart';
import 'package:quickmessage/models/room.dart';
import 'package:quickmessage/models/user.dart';
import 'package:quickmessage/widgets/itemUserChat.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:  AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: getTitle(),
        leading: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            controller.openSetting();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              // radius: 18,
              // backgroundColor: Colors.transparent,
              child: Obx(
                () => controller.currentUser.value.urlPicture == null
                    ? Container()
                    : Image.network(
                        // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlNyI5Bbsl1vq1BQjH9XA-Z4j0Kkk0cEpAnA&usqp=CAU"),
                        controller.currentUser.value.urlPicture,
                        height: 36,
                        width: 36,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
      ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              mySearchBar(context),
              Obx(
                () => controller.currentUser.value.rooms == null
                    ? Container()
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.currentUser.value.rooms.length,
                        itemBuilder: (context, index) {
                          Room room = controller.currentUser.value.rooms[index];
                          return itemUserChat(
                            room: room,
                            onClick: () {
                              controller.openChatRoom(index);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitle() {
    HomeController controller = Get.find<HomeController>();
    return Obx(
      () => controller.currentUser.value.name == null
          ? Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            )
          : Text(
              controller.currentUser.value.name,
              style: TextStyle(color: Colors.white),
            ),
    );
  }

  Widget mySearchBar(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 56,
      child: FlatButton(
        onPressed: () {
          showSearch(context: context, delegate: Search());
        },
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white30,
              size: 24,
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              "Search",
              style: TextStyle(color: Colors.white54, fontSize: 16),
            )
          ],
        ),
        color: Colors.white12,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}


class Search extends SearchDelegate<String> {
  HomeController controller = Get.find<HomeController>();

  @override
  String get searchFieldLabel => 'Search';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
      hintColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color: Colors.white24),),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return widgetListSuggestions(controller.searchUser(query));
  }

  Widget widgetListSuggestions(List<UserChat> suggestionList) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index].name, style: TextStyle(color: Colors.white),),
            onTap: () async {
              controller.createOrOpenNewRoom(suggestionList[index]);
            },
          );
        },
      ),
    );
  }
}

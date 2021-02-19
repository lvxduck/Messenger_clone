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
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        title: getTitle(),
        leading: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            controller.openSetting();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlNyI5Bbsl1vq1BQjH9XA-Z4j0Kkk0cEpAnA&usqp=CAU"),
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

class Search extends SearchDelegate {
  HomeController controller = Get.find<HomeController>();

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
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text(selectedResult),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return widgetListSuggestions(controller.searchUser(query));
  }

  Widget widgetListSuggestions(List<UserChat> suggestionList) {
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].name),
          onTap: () async {
            //Create and open room chat
            controller.createOrOpenNewRoom(suggestionList[index]);
            selectedResult = suggestionList[index].name;
            //showResults(context);
          },
        );
      },
    );
  }
}

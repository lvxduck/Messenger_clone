import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/homeController.dart';
import 'package:quickmessage/models/user.dart';
import 'package:quickmessage/widgets/itemUserChat.dart';

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
          ),
        ],
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Obx(
          () => controller.currentUser.value.rooms == null
          ? Container()
          : ListView.builder(
              itemCount: controller.currentUser.value.rooms.length,
              itemBuilder: (context, index) {
                return ItemUserChat(
                  name: controller.currentUser.value.rooms[index].name,
                  ///haha
                  onClick: () {
                    controller.openChatRoom(index);
                  },
                );
              },
            ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  HomeController controller = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
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
        });
  }
}

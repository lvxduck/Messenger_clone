import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickmessage/controllers/homeController.dart';
import 'package:quickmessage/models/room.dart';
import 'package:quickmessage/models/user.dart';
import 'package:quickmessage/utils/myTheme.dart';
import 'package:quickmessage/widgets/itemUserChat.dart';

class Home extends StatelessWidget {

  final HomeController controller = Get.put(HomeController());
  final myTheme = Get.find<MyTheme>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTheme>(builder: (myTheme)=>Scaffold(
      backgroundColor: myTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: myTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: getTitle(),
        elevation: 0,
        leading: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            controller.openSetting();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Obx(
                () => controller.currentUser.value.urlPicture == null
                    ? Container()
                    : Image.network(
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
                              index: index,
                          isDarkMode: myTheme.theme==ThemeMode.dark);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    ),);
  }

  Widget getTitle() {
    HomeController controller = Get.find<HomeController>();
    return Obx(
      () => controller.currentUser.value.name == null
          ? Text(
              "Loading",
              style: TextStyle(color: myTheme.textColor),
            )
          : Text(
              controller.currentUser.value.name,
              style: TextStyle(color: myTheme.textColor),
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
              color: myTheme.hintTextColor,
              size: 24,
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              "Search",
              style: TextStyle(color: myTheme.hintTextColor, fontSize: 16),
            )
          ],
        ),
        color: myTheme.textFieldColor,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate<String> {
  HomeController controller = Get.find<HomeController>();
  MyTheme myTheme = Get.find<MyTheme>();

  @override
  String get searchFieldLabel => 'Search';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: myTheme.primaryColor,
      // hintColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: myTheme.hintTextColor),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: myTheme.textColor,
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return widgetListSuggestions(controller.searchUser(query));
  }

  Widget widgetListSuggestions(List<UserChat> suggestionList) {
    return Container(
      color: myTheme.primaryColor,
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return itemUserChatForSearch(
            name: suggestionList[index].name,
            urlPicture: suggestionList[index].urlPicture,
            isConnected: true,
            onClick: () {
              controller.createOrOpenNewRoom(suggestionList[index]);
            },
            isDarkMode: myTheme.theme==ThemeMode.dark,
          );
        },
      ),
    );
  }
}

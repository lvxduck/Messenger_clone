import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickmessage/models/message.dart';
import 'package:quickmessage/models/room.dart';
import 'package:quickmessage/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickmessage/screens/setting.dart';
import '../screens/chat.dart';

class HomeController extends GetxController {
  List<UserChat> userChats;
  List<UserChat> recentUser = [];
  Rx<CurrentUser> currentUser = CurrentUser().obs;

  Rx<Message> testMessage = Message(content: "nhan duc").obs;

  HomeController() {
    print("Init HomeController: ");
  }

  //todo: try to not use obs => clear obs

  onInit() {
    _getAllUserChat();
    _getCurrentUser();
    super.onInit();
  }

  void _getAllUserChat() async {
    final snapshot = await FirebaseFirestore.instance.collection("users").get();
    userChats = [];
    snapshot.docs.forEach((doc) {
      print(doc["name"]);
      // print(doc["picture"]);
      if (doc.id == FirebaseAuth.instance.currentUser.uid) {
        currentUser.update((value) => {
              value.uid = FirebaseAuth.instance.currentUser.uid,
              value.name = doc['name'],
              value.urlPicture = doc["picture"],
            });
      }
      userChats.add(UserChat(uid: doc.id, name: doc["name"], urlPicture: doc["picture"]));
    });
  }

  void _getCurrentUser() async {
    /// Get room information, store in user collection
    List<Room> rooms = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('rooms')
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((doc) {
                print(doc['id']);
                rooms.add(Room(
                    id: doc['id'], name: doc['name'], urlPicture: doc['picture'], userChatUid: doc['userChatUid']));
              }),

              /// Get room message, store in room collection
              rooms.forEach((room) {
                List<Message> messages = [];
                FirebaseFirestore.instance
                    .collection("rooms")
                    .doc(room.id)
                    .collection("messages")
                    .orderBy('time')
                    .get()
                    .then((messageSnapshot) => {
                          messageSnapshot.docs.forEach((messageDoc) {
                            // print(messageDoc['content']);
                            messages.add(Message(
                                content: messageDoc['content'], time: messageDoc['time'], uid: messageDoc['uid']));
                          })
                        });
                room.messages = messages;
              }),
            });
    currentUser.update((val) {
      val.rooms = rooms;
    });
  }

  void hardReload() async {
    List<Room> rooms = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('rooms')
        .get()
        .then(
          (snapshot) => {
            snapshot.docs.forEach(
              (doc) {
                print(doc['id']);
                FirebaseFirestore.instance.collection("users").doc(doc['userChatUid']).get().then(
                      (userChat) => {
                        rooms.add(
                          Room(
                            id: doc['id'],
                            name: userChat['name'],
                            urlPicture: userChat['picture'],
                            userChatUid: doc['userChatUid'],
                          ),
                        )
                      },
                    );
              },
            ),
          },
        );
    currentUser.update((val) {
      val.rooms = rooms;
    });
  }

  void createOrOpenNewRoom(UserChat userChat) async {
    recentUser.insert(0, userChat);
    if (recentUser.length > 5) recentUser.removeLast();

    int roomPos = checkRoomExit(userChat);
    if (roomPos == -1) {
      print(" Create room");

      /// Create room
      await FirebaseFirestore.instance
          .collection("rooms")
          .add({
            'users': [FirebaseAuth.instance.currentUser.uid, userChat.uid],
          })
          .catchError((error) => {
                print('Failed to add room'),
                Get.snackbar("ERROR", "Failed to add room"),
              })
          .then((room) => {
                /// Add room to currentUser DB
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .collection('rooms')
                    .doc(room.id)
                    .set({
                      'id': room.id,
                      'name': userChat.name,
                      'picture': userChat.urlPicture,
                      'userChatUid': userChat.uid
                    })
                    .then((value) => {
                          /// Add room to userChat DB
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(userChat.uid)
                              .collection('rooms')
                              .doc(room.id)
                              .set({
                            'id': room.id,
                            'name': currentUser.value.name,
                            'picture': currentUser.value.urlPicture,
                            'userChatUid': currentUser.value.uid
                          }).then((value) => {
                                    /// add room to currentUser
                                    currentUser.update((val) {
                                      val.rooms.add(Room(
                                          id: room.id,
                                          name: userChat.name,
                                          urlPicture: userChat.urlPicture,
                                          userChatUid: userChat.uid,
                                          messages: []));
                                    }),
                                    print(currentUser.value.rooms[0].toString()),
                                    openChatRoom(currentUser.value.rooms.length - 1),
                                  }),
                        })
                    .catchError((error) => {
                          print('Failed to add room'),
                          Get.snackbar("ERROR", "Failed to add room"),
                        }),
              });
    } else {
      print("Room is exit");
      openChatRoom(roomPos);
    }
  }

  void openChatRoom(int index) {
    Get.to(Chat(), arguments: {'room': currentUser.value.rooms[index], 'index': index});
  }

  void openSetting() {
    Get.to(Setting(), arguments: currentUser.value);
  }

  List<UserChat> searchUser(String query) {
    List<UserChat> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentUser
        : suggestionList.addAll(userChats.where((element) => element.name.toLowerCase().contains(query.toLowerCase())));
    return suggestionList;
  }

  int checkRoomExit(UserChat userChat) {
    for (int i = 0; i < currentUser.value.rooms.length; i++) {
      if (currentUser.value.rooms[i].userChatUid == userChat.uid) {
        return i;
      }
    }
    return -1;
  }
}

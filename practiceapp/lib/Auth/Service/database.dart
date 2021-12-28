import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practiceapp/Auth/modals/user.dart';

List<Users> listUsers = [];

class DatabaseMethods{

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance.collection("Users")
        .where("name", isEqualTo: username)
        .get();
  }

  Future<QuerySnapshot> getUserByUserEmail(String userEmail) async {
    var user = userEmail.trimRight();
    print(user);
    dynamic val = await FirebaseFirestore.instance.collection("Users")
        .where("email", isEqualTo: user)
        .get();
    return val ;
  }

  uploadUserInfo(userMap ){
    FirebaseFirestore.instance.collection("Users").add(userMap).catchError((e){
      print(e.toString());
    });
  }

  createChatRoom( String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  addConversationMessage(String ChatRoomId, messageMap) async {
    await FirebaseFirestore.instance.collection("ChatRoom")
        .doc(ChatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){ print(e.toString());});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversationMessage(String ChatRoomId) {
    return FirebaseFirestore.instance.collection("ChatRoom")
        .doc(ChatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRooms(String email){
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: email)
        .snapshots();
  }
  getAllUser() {
    return FirebaseFirestore.instance
        .collection("Users").snapshots().map((users) {
          final List<Users> list = [];
          for (final DocumentSnapshot<Map<String, dynamic>> doc in users.docs){
            list.add(Users.fromDocumentSnapshot(doc: doc));
          }
          return list;
    });
  }

  Users getUser(String email){
    var list =  listUsers.where((element) => element.email.replaceAll('@gmail.coom', "") == email).toList();
    return list[0];
  }


}
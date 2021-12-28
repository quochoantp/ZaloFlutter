
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practiceapp/Auth/Service/constant.dart';
import 'package:practiceapp/Auth/Service/database.dart';
import 'package:practiceapp/Auth/modals/user.dart';
import 'package:practiceapp/messenge_screen/conversation_screen.dart';
import 'dart:math' as math;

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  DatabaseMethods _data = DatabaseMethods();
  Stream? userStream;
  List<Users> listUsers = [];
  Users? user;

  @override
  void initState() {
    super.initState();
  }
  // Tạo phòng chat
  createChatRoomAndStartConversation( {required String userEmail,required String userName})async {
    if(userEmail != Constants.myEmail){
      String chatRoomId  =  getChatRoomId(userEmail, Constants.myEmail);
      List<String> users = [userName, Constants.myName ];
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "chatroomId" :chatRoomId
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId: chatRoomId, User: userName,)
      ));
    }else{
      print("you cannot send message to yourself") ;
      print("${Constants.myName}");
    }
  }

  Stream<List<Users>> getAllUser() {
    return FirebaseFirestore.instance
        .collection("Users").snapshots().map((users) {
      final List<Users> list = [];
      for (final DocumentSnapshot<Map<String, dynamic>> doc in users.docs){
        list.add(Users.fromDocumentSnapshot(doc: doc));
      }
      return list;
    });
  }
  // tạo id phòng chat
  getChatRoomId(String a, String b){
    if(int.parse(a) > int.parse(b))
      {
        return "$a\_$b";
      } else {
      return "$b\_$a";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlue, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add,
                            color: Colors.lightBlue,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Thêm bạn bè',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
             StreamBuilder<List<Users>>(
               stream: getAllUser(),
               builder: (context, userSnapshot) {
                 return userSnapshot.connectionState == ConnectionState.waiting ? Center(
                   child: CircularProgressIndicator(),
                 ) : ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  itemBuilder: (context, index) {
                    Users user = userSnapshot.data![index];
                    return user.email.replaceAll('@gmail.com', '') != Constants.myEmail?  InkWell(
                      onTap: () {
                        createChatRoomAndStartConversation(userEmail: user.email.replaceAll("@gmail.com", ""),userName: user.name);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Flexible(
                                flex: 2,
                                child: SizedBox.fromSize(
                                  size: Size(55,55),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                            colors: [
                                              Color((math.Random().nextDouble() *
                                                  0xFFFFFF)
                                                  .toInt())
                                                  .withOpacity(1.0),
                                              Colors.lightBlue
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)),
                                    child: Center(
                                      child: Text(
                                        user.name.split(' ').last,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(width: 10,),
                            Flexible(
                                flex: 7,
                                child: Text(
                                  user.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                )),
                          ],
                        ),
                      ),
                    ) : Container();
                  },
                  itemCount: userSnapshot.data!.length,
            );
               }
             ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practiceapp/Auth/Service/constant.dart';
import 'package:practiceapp/Auth/Service/database.dart';
import 'dart:math' as math;

import 'conversation_screen.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  DatabaseMethods _data = DatabaseMethods();
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatRoomsStream;

  // thông tin user
  getChatRooms(){
    _data.getChatRooms(Constants.myName);
  }

  @override
  void initState() {
    chatRoomsStream = _data.getChatRooms(Constants.myName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: chatRoomsStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
            return  snapshot.hasData ? ListView.separated(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 15,bottom: 15, left: 15),
              itemBuilder: (context, index)  {
                String chatRoom = snapshot.data!.docs[index].data()['chatroomId'];
                var list = snapshot.data!.docs[index].data()['users'].toString().replaceAll(']', '').replaceAll('[', '').split(',');
                list.removeWhere((element) => element== Constants.myName);
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId: chatRoom ,User: list[0]),));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox.fromSize(
                        size: Size(55,55),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), Colors.lightBlue],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight
                            )
                          ),
                          child: Center(
                            child: Text(list[0].toString().split(' ').last, style: TextStyle(
                               fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    list[0],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      '10p',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'tin nhắn...',
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Container(
                padding: const EdgeInsets.only(left: 70),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: Colors.black12,
                ),
              ),
              itemCount: snapshot.data!.docs.length,
          ) :  Container();
        }
      ),
    );
  }
}


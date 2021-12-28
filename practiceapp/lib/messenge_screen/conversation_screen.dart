import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practiceapp/Auth/Service/constant.dart';
import 'package:practiceapp/Auth/Service/database.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String User;

  const ConversationScreen(
      {Key? key, required this.chatRoomId, required this.User})
      : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  final ScrollController _scrollController = new ScrollController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> chatMessagesStream =
      databaseMethods.getConversationMessage(widget.chatRoomId);

  Widget chatMessageList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: chatMessagesStream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                reverse: true,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot
                        .data!.docs[snapshot.data!.docs.length - index - 1]
                        .data()['message'],
                    isSendByMe: snapshot
                            .data!.docs[snapshot.data!.docs.length - index - 1]
                            .data()["sendBy"] ==
                        Constants.myEmail,
                    time: snapshot
                        .data!.docs[snapshot.data!.docs.length - index - 1]
                        .data()['time'],
                    checkTime: (snapshot
                            .data!.docs[snapshot.data!.docs.length - index - 1]
                            .data()['time'] -
                        snapshot.data!
                            .docs[snapshot.data!.docs.length - index -1]


                            .data()['time']) >= 60000 ,
                  );
                })
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myEmail,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessage(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    chatMessagesStream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.User,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(child: chatMessageList()),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn..',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.lightBlueAccent,
                      size: 30,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe, checkTime;
  final int time;

  MessageTile(
      {required this.message,
      required this.isSendByMe,
      required this.time,
      required this.checkTime});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    String timeSendMessage = DateFormat('hh:mm').format(dateTime);
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [const Color(0xffa2c0dc), const Color(0xff70b0ee)]
                    : [
                        const Color(0xffd9e1e7),
                        const Color(0xffd9e1e7),
                      ]),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400), ),
            SizedBox(height: 3,),
            Text(
              timeSendMessage,
              style: TextStyle(color: Colors.black54, fontSize: 10),
              textAlign: TextAlign.right,
            ) ,
          ],
        ),
      ),
    );
  }
}

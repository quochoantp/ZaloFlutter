import 'package:flutter/material.dart';
import 'package:practiceapp/contact_screen/alphabet_scroll_page.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _contacts = <String>["Asdfg", "Bnm", "Cvbnm"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Danh bạ"),
          actions: [
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {},
            )
          ],
        ),
        // body: Container(
        //   padding: EdgeInsets.all(20),
        //   child: Column(
        //     children: [
        //       ListView.builder(
        //         shrinkWrap: true,
        //         itemCount: _contacts.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //               leading: CircleAvatar(
        //                 child: Text(
        //                     _contacts[index].substring(0, 1).toUpperCase()),
        //               ),
        //               title: Text(_contacts[index]),
        //               trailing: Row(
        //                   mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   IconButton(icon: Icon(Icons.phone_outlined), onPressed: () {  },),
        //                   IconButton(icon: Icon(Icons.video_call_outlined), onPressed: () {  },),
        //                 ],
        //               ));
        //         },
        //       )
        //     ],
        //   ),
        // )
      body: AlphabetScrollPage(
        items: [
          "Nam Anh",
          "nadsdas",
          "Hoan",
          "Long",
          "Viet",

        ],
      ),
    );
  }
}

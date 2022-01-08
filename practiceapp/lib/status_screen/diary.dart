import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practiceapp/Auth/Service/constant.dart';
import 'package:practiceapp/Auth/Service/database.dart';
import 'package:practiceapp/Auth/modals/user.dart';
import 'createpost.dart';
import 'post_container.dart';

class Diary extends StatelessWidget{
  DatabaseMethods? db;
  Users? user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CreatePostContainer(),
            ),
            SliverToBoxAdapter(
              child: PostContainer(
                caption: 'Hello App',
                name: Constants.myName,
                time_ago: '1 hour ago',
                imageUrl: 'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
                avatarUrl: 'https://scr.vn/wp-content/uploads/2020/08/%E1%BA%A2nh-hot-girl-l%C3%A0m-avt.jpg',
              ),
            ),
          ],
        ),
      ),
    );
  }

}
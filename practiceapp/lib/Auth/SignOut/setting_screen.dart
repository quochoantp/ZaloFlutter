import 'package:flutter/material.dart';
import 'package:practiceapp/Auth/Service/auth_service.dart';
import 'package:practiceapp/Auth/SignOut/custom_item_card.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Data> datas = [
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: true),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: true),
    Data(
        title: 'Quyền riêng tư',
        icon: Icons.privacy_tip,
        onPressed: () {},
        isMargin: false),
    Data(
        title: 'Logout',
        icon: Icons.logout,
        onPressed: () async{
            //await authService.signOut();
          },
        isMargin: false),
  ];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);//NDL Long add
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Setting'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.navigate_before))),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: datas.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap:()  async {
                      if(index == datas.length-1) await authService.signOut();
                      Navigator.pushNamedAndRemoveUntil(context, "/signin", (r) => false);
                    },
                    child : CutomItemCart(
                    isShowRightIcon: true,
                    icon: datas[index].icon,
                    title: datas[index].title,
                    isMargin: datas[index].isMargin,
                    isShowDivider:  !datas[index].isMargin,

                  ));


                }),
          ),
        ],
      ),
    );
  }
}

class Data {
  IconData icon;
  String title;
  Function onPressed;
  bool isMargin;
  Data(
      {required this.icon,
      required this.title,
      required this.onPressed,
      required this.isMargin});
}

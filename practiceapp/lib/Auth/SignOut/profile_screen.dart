import 'package:flutter/material.dart';
import 'package:practiceapp/Auth/SignOut/custom_item_card.dart';
import 'package:practiceapp/Auth/SignOut/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.settings, color: Colors.transparent),
            const Text('Profile'),
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingScreen()),
                      );
                    },
                    icon: const Icon(Icons.settings))),
          ],
        ),
      ),
      body: Column(children: [
        _buildInforProfle(),
        Expanded(
            child: ListView(
          children: const [
            SizedBox(height: 10),
            CutomItemCart(
              icon: Icons.qr_code,
              title: 'Quét mã qr',
              subTitle: 'Lưu trữ và xuất trình các mã QR quan trọng',
              isMargin: true,
            ),
            CutomItemCart(
              icon: Icons.card_giftcard,
              title: 'Quét mã qr',
              subTitle: 'Lưu trữ và xuất trình các mã QR quan trọng',
              isMargin: true,
            ),
            CutomItemCart(
              icon: Icons.card_giftcard,
              title: 'Quét mã qr',
              isShowRightIcon: true,
              isShowDivider: true,
            ),
            CutomItemCart(
              icon: Icons.card_giftcard,
              title: 'Quét mã qr',
              isShowRightIcon: true,
            ),
          ],
        ))
      ]),
    );
  }

  _buildInforProfle() {
    return Container(
      color: Colors.grey.withOpacity(0.3),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Image.network(
              'https://scr.vn/wp-content/uploads/2020/08/%E1%BA%A2nh-hot-girl-l%C3%A0m-avt.jpg',
              height: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Nguyễn Duy Long',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Xem trang cá nhân',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child:
                  //  Image.asset('lib/asset/icons/ic_heart.png',
                  //     height: 30, width: 30)
                  Icon(Icons.person))
        ],
      ),
    );
  }
}

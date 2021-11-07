import 'package:flutter/material.dart';
import 'package:zalo_app/model/CountryModel.dart';

import 'CountryCode.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  String countryName = "VN";
  String countryCode = "+84";
  TextEditingController _controller = TextEditingController();
  // TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  // AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tao tai khoan'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Nhap so dien thoai cua ban de tao tai khoan moi",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              countryCard(),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  showMydialog();
                },
                child: Container(
                  color: Color(0xFF0288D1),
                  height: 40,
                  child: Center(
                    child: Text(
                      "Tiep tuc",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builer) => CountryCode(
                      setCountryData: setCountryData,
                    )));
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.1,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.blue,
          width: 1.8,
        ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                  child: Text(
                countryCode,
                style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
              )),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nhap so dien thoai',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Navigator.pop(context);
  }

  Future<void> showMydialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Xac nhan so dien thoai " + countryCode,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,),
                  ),
                Text(
                  _controller.text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: 10
                  ),
                Text(
                  "Ma xac thuc gui toi so dien thoai nay",
                style: TextStyle(fontSize: 14),
                  ),
                ],
                ),
              ),
              actions: [
                TextButton(onPressed: () {}, 
                  child: Text(
                    "Huy", 
                    style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ),
                TextButton(onPressed: () {}, 
                  child: Text(
                    "Dong y", 
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                      )
                    ),
              ],
        );
      },
    );
  }
}

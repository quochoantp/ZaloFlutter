import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practiceapp/Auth/CountryCode.dart';
import 'package:practiceapp/Auth/CountryModel.dart';
import 'package:practiceapp/Auth/SignUp/OTPScreen.dart';

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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('Tao tai khoan'),
      ),
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Container(
                color: Colors.grey[100],
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Nhap so dien thoai cua ban de tao tai khoan moi",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  countryCard(),
                  number(),
                ],
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  if (_controller.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Thong bao"),
                          content: Text("Vui long nhap so dien thoai"),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (_controller.text.length < 9 ||
                      _controller.text.length > 11) {
                    showMyDialog2();
                  } else {
                    showMyDialog1();
                  }
                  // showMydialog();
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
        // width: MediaQuery.of(context).size.width / 1.1,
        width: 80,
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
              // width: MediaQuery.of(context).size.width - 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 1.8,
            ),
          )),
      child: TextFormField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Nhap so dien thoai',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
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

  Future<void> showMyDialog1() {
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _controller.text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Ma xac thuc gui toi so dien thoai nay",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Tu choi",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => OTPScreen(
                            countryCode: countryCode,
                            number: _controller.text,
                          )));
                },
                child: Text(
                  "Dong y",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                )),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog2() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text("So dien thoai khong hop le",
                    style: TextStyle(fontSize: 14, color: Colors.red)),
                Text("Vui long thu lai sau.",
                    style: TextStyle(fontSize: 14, color: Colors.red))
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Dong y",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                )),
          ],
        );
      },
    );
  }
}
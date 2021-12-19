import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practiceapp/Auth/CountryCode.dart';
import 'package:practiceapp/Auth/CountryModel.dart';
import 'package:practiceapp/Auth/Service/auth_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget{
  SignInPage({Key? key}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage>{

  // firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  String countryName = "VN";
  String countryCode = "+84";
  bool obscure = true;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  // AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
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
        title: Text('Dang nhap'),
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
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  password(),
                ],
              ),
              if(authService.errorMessage !='')
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 80, 0),
                  child: Text(
                    authService.errorMessage,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 315, 0),
                child: Text(
                  "Lấy lại mật khẩu",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 15,
                      // fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_phoneController.text.isEmpty) {
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
                          } else if (_phoneController.text.length < 9 ||
                              _phoneController.text.length > 11) {
                            showMyDialog2();
                          } else {
                            authService.signInWithEmailAndPassword(
                                _phoneController.text+"@gmail.com", _pwdController.text);
                          }
                        },
                        child: Text(
                            "Đăng nhập"
                        ),
                      )
                  )
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


  void obscurePassword(){
    setState(() {
      obscure = !obscure;
    });
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
        controller: _phoneController,
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

  Widget password() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.2,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 1.8,
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 150,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: TextField(
              controller: _pwdController,
              obscureText: obscure,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Mật khẩu',
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: obscurePassword,
            child: Text(
              obscure? "Hiện" : "Ẩn",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
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
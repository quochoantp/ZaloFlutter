import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practiceapp/Auth/CountryCode.dart';
import 'package:practiceapp/Auth/CountryModel.dart';
import 'package:practiceapp/Auth/Service/auth_service.dart';
import 'package:practiceapp/Auth/Service/database.dart';
import 'package:practiceapp/Auth/Service/helper_function.dart';
import 'package:practiceapp/Auth/StartPage.dart';
import 'package:practiceapp/home_screen/home_screen.dart';
import 'package:practiceapp/widgets/custom_loading.dart';
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

  AuthService _authService = AuthService();
  DatabaseMethods databaseMethods = DatabaseMethods();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;

  void SignIn(){
    _authService.signInWithEmailAndPassword(
        _phoneController.text+"@gmail.com", _pwdController.text);

  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StartPage()),
              );
            },
            color: Colors.white, icon: Icon(Icons.arrow_back),
          ),
        ),
        title: Text('Đăng nhập'),
        centerTitle: true,
      ),
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5),
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  password(),
                ],
              ),
              if(authService.errorMessage !='')
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      authService.errorMessage,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 25,),
              Center(
                child: Text(
                  "Lấy lại mật khẩu",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 15,
                      // fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(context: context, builder: (context) => DialogLoading(),);
                          if (_phoneController.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Thông báo"),
                                  content: Text("Vui lòng nhập số điện thoại"),
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
                            await databaseMethods.getUserByUserEmail("${_phoneController.text}@gmail.com")
                                .then((val){
                              String username ='';
                              String email  ='';
                              val.docs.forEach((element) {
                                username = element["name"];
                                email = element["email"].replaceAll("@gmail.com", '');
                                print("username:" + username);
                                print("email:" + email);
                              });
                              HelperFunctions.saveUserNameSharedPreference(username);
                              HelperFunctions.saveUserEmailSharedPreference(email);
                              print('đăng nhập');
                            });
                            await authService.signInWithEmailAndPassword(
                                _phoneController.text+"@gmail.com", _pwdController.text).then((val) {
                              HelperFunctions.saveUserLoggedInSharedPreference(true);
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                            }
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          child: Text(
                              "Đăng nhập", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
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
                builder: (builder) => CountryCode(
                  setCountryData: setCountryData,
                )));
      },
      child: Container(
        height: 50,
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
                    ),
                  )),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            Container(
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
          hintText: 'Nhập số điện thoại',
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
      width: MediaQuery.of(context).size.width-50,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 1.8,
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextFormField(
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
                Text("Số điện thoại không hợp lệ!",
                    style: TextStyle(fontSize: 14, color: Colors.red)),
                Text("Vui lòng nhập lại!",
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
                  "Ok",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                )),
          ],
        );
      },
    );
  }

}
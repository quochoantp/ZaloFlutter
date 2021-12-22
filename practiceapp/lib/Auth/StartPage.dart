import 'package:flutter/material.dart';
import 'package:practiceapp/Auth/SignUp/SignUpPage.dart';
import 'package:practiceapp/Auth/Signin/Signin.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                'Zalo',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 250,
              ),
              signInButton(),
              SizedBox(
                height: 20,
              ),
              signUpButton(),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tieng Viet",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "English",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "日本語",
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }

  Widget signUpButton() {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFE0E0E0),
          ),
          child: Center(
            child: Text(
              'Đăng ký',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ));
  }

  Widget signInButton() {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        },
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              'Đăng nhập',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
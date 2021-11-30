import 'package:flutter/material.dart';
import 'package:zalo_app/Signup/SignUpPage.dart';

import 'Signup/StartPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF0288D1), accentColor: Color(0x664FC37F)),
      home: StartPage(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zalo_app/Signup/SignUpPage.dart';

import 'Signup/StartPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practiceapp/Auth/Service/auth_service.dart';
import 'package:practiceapp/Auth/Signin/Signin.dart';
import 'package:provider/provider.dart';

import 'Auth/Service/wrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
        providers : [
          ChangeNotifierProvider<AuthService>.value(value: AuthService()),
          //StreamProvider<User>.value(AuthService().user)
          //Provider<AuthService>(create: (_) => AuthService(),),
        ],
        child : MaterialApp(
          // theme: ThemeData(
          //     primaryColor: Color(0xFF0288D1	), accentColor: Color(0x664FC37F)),
          //home: SignInPage(),
          initialRoute: '/',
          routes: {
            '/' : (context) => Wrapper(),
            '/signin' : (context) => SignInPage(),
          },
        )
    );
  }
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practiceapp/Auth/Service/auth_service.dart';
import 'package:practiceapp/Auth/SignOut/profile_screen.dart';
import 'package:practiceapp/Auth/Signin/Signin.dart';
import 'package:practiceapp/Auth/UserModel.dart';
import 'package:practiceapp/chatscreen.dart';
import 'package:practiceapp/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot){
        if(snapshot.hasError) debugPrint('movieTitle');
        if(snapshot.connectionState == ConnectionState.active){
          final User? user = snapshot.data;
          return user == null ? SignInPage() : HomeScreen();
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        }
      });
  }
}
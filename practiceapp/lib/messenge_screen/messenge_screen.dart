import 'package:flutter/material.dart';

class MessengeScreen extends StatefulWidget {
  const MessengeScreen({Key? key}) : super(key: key);

  @override
  _MessengeScreenState createState() => _MessengeScreenState();
}

class _MessengeScreenState extends State<MessengeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(" MessengeScreen")),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zalo_app/model/UserModel.dart';

import 'HomeScreen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String gender = 'Nam';
  TextEditingController genderController = TextEditingController();
  TextEditingController name = TextEditingController();
  late DateTime date;
  TextEditingController dateController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPw = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dang ky', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Nhap ten ban muon hien thi',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ban chua nhap ten';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value as TextEditingController;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Gioi tinh',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 'Nam',
                      groupValue: gender,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          gender = 'Nam';
                        });
                      },
                    ),
                    Text('Nam'),
                    Radio(
                      value: 'Nu',
                      groupValue: gender,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          gender = 'Nu';
                        });
                      },
                    ),
                    Text('Nu'),
                  ],
                ),
                TextFormField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(hintText: 'Ngay sinh'),
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        helpText: 'Chon ngay sinh',
                        cancelText: 'Huy',
                        confirmText: 'Xac nhan',
                        errorInvalidText: 'Khong dung',
                        errorFormatText: 'Khong dung dinh dang',
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    if (date != null && date != DateTime.now())
                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(date);
                  },
                  onSaved: (value) {
                    date = DateFormat('dd/MM/yyyy').parse(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ban chua nhap ngay sinh';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Mat khau',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ban chua nhap mat khau';
                    }
                    if (value.length < 6) {
                      return 'Mat khau phai co it nhat 6 ky tu';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: confirmPw,
                  decoration: InputDecoration(
                    labelText: 'Nhap lai mat khau',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ban chua nhap lai mat khau';
                    }
                    if (confirmPw.text != password.text) {
                      return 'Mat khau khong khop';
                    }
                  },
                  onSaved: (value) {
                    confirmPw = value as TextEditingController;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Dang ky', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      print("successful");
                    } else {
                      print("UnSuccessfull");
                    }
                  },
                ),
                //register
              ],
            ),
          ),
        )));
  }

  Future<void> sigUp() async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: '', password: password.text)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(
            msg: e.message,
            // toastLength: Toast.LENGTH_SHORT,
            // gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      print("UnSuccessfull");
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    // userModel.email = user!.email;
    userModel.uid = user!.uid;
    userModel.name = name.text;
    userModel.gender = gender;
    userModel.date = date;
    userModel.confirmPw = confirmPw.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}

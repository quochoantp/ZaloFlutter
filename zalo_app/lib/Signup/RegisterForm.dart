import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String gender = 'Nam';
  String name = '';
  late DateTime date;
  final dateController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPw = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                    name = value!;
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
                      return;
                    } else {
                      print("UnSuccessfull");
                    }
                  },
                ),
              ],
            ),
          ),
        )));
  }
}

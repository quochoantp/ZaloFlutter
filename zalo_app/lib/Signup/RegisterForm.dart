import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String gender = 'Nam';
  final dateController = TextEditingController();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nhap ten ban muon hien thi',
                  ),
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
                TextField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                    hintText: 'Ngay sinh'
                  ),
                  onTap: () async {
                  var date =  await showDatePicker(
                    context: context, 
                    initialDate:DateTime.now(),
                    helpText: 'Chon ngay sinh',
                    cancelText: 'Huy',
                    confirmText: 'Xac nhan',
                    errorInvalidText: 'Khong dung',
                    errorFormatText: 'Khong dung dinh dang',
                    firstDate:DateTime(1900),
                    lastDate: DateTime(2100));
                    if (date != null &&  date != DateTime.now())
                      dateController.text = DateFormat('dd/MM/yyyy').format(date);
                    }      
                  ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Mat khau',
                    
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nhap lai mat khau',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Dang ky', style: TextStyle(color: Colors.white)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ));
  }
}

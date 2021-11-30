import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:zalo_app/Signup/RegisterForm.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.countryCode, required this.number})
      : super(key: key);
  final String number;
  final String countryCode;
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nhap ma OTP'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.grey[100],
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: Text(
                  "Vui long khong chia se ma xac thuc de tranh mat tai khoan",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Da gui ma OTP den so ' +
                      '(' +
                      widget.countryCode +
                      ') ' +
                      widget.number,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '\n\n',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Vui long dien ma xac nhan vao o ben duoi',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ])),
              OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width * 0.8,
                fieldWidth: 30,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
                textFieldAlignment: MainAxisAlignment.center,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print("Complete" + pin);
                },
              ),
              SizedBox(
                height: 20,
              ),
              bottomButton('Gui lai ma'),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builer) => RegisterForm()));
                },
                child: Container(
                  color: Color(0xFF0288D1),
                  height: 40,
                  child: Center(
                    child: Text(
                      "Tiep tuc",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }

  Widget bottomButton(String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

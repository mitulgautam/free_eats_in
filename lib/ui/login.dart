import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/resources/themes.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _spacer16 = SizedBox(height: 16.0);
  final _spacer8 = SizedBox(height: 8.0);
  final _otpState = GlobalKey<FormState>();
  final _mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Image.asset("assets/images/otp.jpg"),
              Text("Enter your mobile number to\ncreate account or sign up",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0)),
              _spacer16,
              _spacer8,
              Text("We will send you one time otp\npassword (OTP)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.black45)),
              _spacer8,
              Form(
                  key: _otpState,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: TextFormField(
                          controller: _mobileNumber,
                          textAlign: TextAlign.center,
                          validator: (_) {
                            return _.length < 10
                                ? "Mobile number should be equal to 10"
                                : null;
                          },
                          decoration: InputDecoration(
                              hintText: "+91 1234567890",
                              hintStyle: TextStyle(color: Colors.black12)),
                          keyboardType: TextInputType.number,
                          style:
                              TextStyle(fontSize: 26.0, letterSpacing: 3.0)))),
              _spacer16,
              _spacer16,
              MaterialButton(
                  onPressed: () {
                    if (_otpState.currentState.validate()) {
                      _otpState.currentState.save();
                    }
                  },
                  color: Themes.DARK_BROWN_COOKIE,
                  shape: StadiumBorder(),
                  child: Text("Send", style: TextStyle(color: Colors.white)))
            ])));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/user_login_response_model.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/common_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _spacer16 = SizedBox(height: 16.0);
  final _spacer8 = SizedBox(height: 8.0);
  final _mobileState = GlobalKey<FormState>();
  final _otpState = GlobalKey<FormState>();
  final _mobileNumber = TextEditingController();
  final _otpVal1 = TextEditingController();
  final _otpVal2 = TextEditingController();
  final _otpVal3 = TextEditingController();
  final _otpVal4 = TextEditingController();
  final _otpVal5 = TextEditingController();
  final _otpVal6 = TextEditingController();
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final focusNode4 = FocusNode();
  final focusNode5 = FocusNode();
  final focusNode6 = FocusNode();
  bool _isOtpScree = false;
  String _verificationId;
  FirebaseAuth _firebaseAuth;
  SharedPreferences _sharedPrefs;

  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    loadSharedPrefs();
    super.initState();
  }

  loadSharedPrefs() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(child: _isOtpScree ? _otpView() : _numberView()),
        ));
  }

  Widget _numberView() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Welcome", style: TextStyle(fontSize: 26.0)),
              Image.asset("assets/images/otp.jpg",
                  width: MediaQuery.of(context).size.width * .7),
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
                  key: _mobileState,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: TextFormField(
                              controller: _mobileNumber,
                              textAlignVertical: TextAlignVertical.bottom,
                              textAlign: TextAlign.center,
                              maxLength: 10,
                              validator: (_) {
                                return _.length < 10
                                    ? "Mobile number should be equal to 10"
                                    : null;
                              },
                              decoration: InputDecoration(
                                  hintText: "1234567890",
                                  hintStyle: TextStyle(color: Colors.black12)),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 26.0, letterSpacing: 3.0))),
                    ],
                  )),
              _spacer16,
              _spacer16,
              MaterialButton(
                  onPressed: () {
                    if (_mobileState.currentState.validate()) {
                      _mobileState.currentState.save();
                      setState(() {
                        _isOtpScree = true;
                      });
                      signInWithOtp(_mobileNumber.text);
                      print("MOBILE NUMBER: " + "+91" + _mobileNumber.text);
                    }
                  },
                  color: Themes.DARK_BROWN_COOKIE,
                  shape: StadiumBorder(),
                  child: Text("Send", style: TextStyle(color: Colors.white)))
            ]),
      ),
    );
  }

  Widget _otpView() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Verify", style: TextStyle(fontSize: 26.0)),
              Image.asset("assets/images/fill.jpg",
                  width: MediaQuery.of(context).size.width * .7),
              Text("Enter your otp to verify and login",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0)),
              _spacer16,
              _spacer8,
              Text("We have sent the OTP on ${_mobileNumber.text}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.black45)),
              _spacer8,
              Form(
                  key: _otpState,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _singleDigit(_otpVal1, focusNode1, focusNode2),
                        _singleDigit(_otpVal2, focusNode2, focusNode3),
                        _singleDigit(_otpVal3, focusNode3, focusNode4),
                        _singleDigit(_otpVal4, focusNode4, focusNode5),
                        _singleDigit(_otpVal5, focusNode5, focusNode6),
                        _singleDigit(_otpVal6, focusNode6, null)
                      ])),
              _spacer8,
              /*Text("If you didn't receive code",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, color: Colors.black38)),
              _spacer16,*/
              _spacer16,
              MaterialButton(
                  onPressed: () async {
                    try {
                      if (_otpState.currentState.validate()) {
                        CommonWidget.loading(context);
                        _otpState.currentState.save();
                        String code = "";
                        code += _otpVal1.text;
                        code += _otpVal2.text;
                        code += _otpVal3.text;
                        code += _otpVal4.text;
                        code += _otpVal5.text;
                        code += _otpVal6.text;
                        print("OTP CODE " + code);
                        AuthCredential _authCred =
                            PhoneAuthProvider.getCredential(
                                verificationId: _verificationId, smsCode: code);
                        AuthResult result =
                            await _firebaseAuth.signInWithCredential(_authCred);
                        FirebaseUser _user = result.user;
                        if (_user != null) {
                          _sharedPrefs.setString(
                              Strings.LOGIN_NUMBER, "+91" + _mobileNumber.text);
                          _sharedPrefs.setString(
                              Strings.LOGIN_FIREBASE_UID, _user.uid);
                          dynamic response =
                              await API.userLogin(_mobileNumber.text);
                          Navigator.pop(context);
                          if (response is bool && response == false) {
                            Navigator.pushReplacementNamed(
                                context, Strings.SIGN_UP, arguments: {
                              Strings.LOGIN_NUMBER: "+91" + _mobileNumber.text
                            });
                          } else if (response is UserLoginResponseModel) {
                            Navigator.pushReplacementNamed(
                                context, Strings.HOMEPAGE,
                                arguments:
                                    userLoginResponseModelToJson(response));
                          }
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  color: Themes.DARK_BROWN_COOKIE,
                  shape: StadiumBorder(),
                  child: Text("Verify", style: TextStyle(color: Colors.white)))
            ]),
      ),
    );
  }

  Widget _singleDigit(TextEditingController _textController,
      FocusNode _currentNode, FocusNode _nextNode) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * .1,
          child: TextFormField(
            focusNode: _currentNode,
            autofocus: _currentNode == focusNode1 ? true : false,
            controller: _textController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 26.0, letterSpacing: 3.0),
            textInputAction:
                _nextNode == null ? TextInputAction.done : TextInputAction.next,
            onChanged: (_) {
              if (_.length > 0) if (_nextNode != null)
                FocusScope.of(context).requestFocus(_nextNode);
            },
          )),
    );
  }

  void signInWithOtp(String number) {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91" + number,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential cred) async {
          AuthResult result = await _firebaseAuth.signInWithCredential(cred);
          FirebaseUser _user = result.user;
          if (_user != null) Navigator.pushNamed(context, Strings.HOMEPAGE);
        },
        verificationFailed: (AuthException authException) {
          print(authException);
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        });
  }
}

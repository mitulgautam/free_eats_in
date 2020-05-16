import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/user_signup_model.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/common_widget.dart';

class SignUp extends StatefulWidget {
  final Map<String, String> arguments;

  const SignUp({Key key, this.arguments}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _email;
  TextEditingController _city;
  TextEditingController _pincode;

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _city = TextEditingController();
    _pincode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _city.dispose();
    _pincode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _textFormField(_firstName, "First Name"),
                _textFormField(_lastName, "Last Name"),
                _textFormField(_email, "E-mail"),
                _textFormField(_city, "City"),
                _textFormField(_pincode, "Pincode"),
                MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        CommonWidget.loading(context);
                        UserSignUpModel _signUpData = UserSignUpModel(
                            city: _city.text,
                            email: _email.text,
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            phoneNumber: widget.arguments[Strings.LOGIN_NUMBER],
                            pincode: _pincode.text);
                        dynamic response = await API.userSignUp(_signUpData);

                        Navigator.pop(context);
                        if (response is bool && response == false) {
                          print("Error occoured");
                        } else {
                          Navigator.pushReplacementNamed(
                              context, Strings.HOMEPAGE);
                        }
                      }
                    },
                    child: Text(" Sign Up ", style: TextStyle(fontSize: 18.0)),
                    shape: StadiumBorder(),
                    color: Themes.DARK_BROWN_COOKIE,
                    textColor: Colors.white)
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _textFormField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: controller,
          validator: (_) => _.length < 4 ? "Not a valid input" : null,
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: label)),
    );
  }
}

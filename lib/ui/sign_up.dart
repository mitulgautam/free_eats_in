import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/city_model.dart';
import 'package:freeeatsin/core/model/user_signup_model.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/strings.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/common_widget.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  final Map<String, String> arguments;

  const SignUp({Key key, this.arguments}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final City selectCity = City(city: "Select City");
  bool autoValidate = false;
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _email;
  TextEditingController _pincode;
  File _image;
  List<City> data;
  List<City> _cities;
  States _states;
  City _city;

  @override
  void initState() {
    _cities = [selectCity];
    _city = selectCity;
    CommonWidget.loadCrosswordAsset("assets/images/cities.json").then((value) {
      data = cityFromJson(value);
      data.sort((a, b) => a.city.compareTo(b.city));
      setState(() {
        isLoading = false;
      });
    });
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _pincode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
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
                    child: isLoading
                        ? CircularProgressIndicator()
                        : SingleChildScrollView(
                            child: Form(
                                key: _formKey,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: GestureDetector(
                                              onTap: () async {
                                                _image =
                                                    await ImagePicker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {});
                                              },
                                              child: DottedBorder(
                                                  dashPattern: [4, 8, 1],
                                                  color:
                                                      Themes.DARK_BROWN_COOKIE,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: _image == null
                                                          ? Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                Icons.image,
                                                                color: Themes
                                                                    .DARK_BROWN_COOKIE,
                                                              ))
                                                          : SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3,
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Image.file(
                                                                      _image,
                                                                      fit: BoxFit
                                                                          .cover)),
                                                            ))))),
                                      SizedBox(height: 16.0),
                                      _textFormField(
                                          _firstName,
                                          "First Name",
                                          (String _) => _.length < 3
                                              ? "First Name should be greater than 3"
                                              : null,
                                          null),
                                      _textFormField(_lastName, "Last Name",
                                          (String _) => null, null),
                                      _textFormField(
                                          _email,
                                          "E-mail",
                                          (_) =>
                                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(_)
                                                  ? null
                                                  : "Not a valid email address!",
                                          TextInputType.emailAddress),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButtonFormField<States>(
                                            autovalidate: autoValidate,
                                            validator: (_) => _ == null
                                                ? "Please Select State"
                                                : null,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "State"),
                                            isExpanded: true,
                                            value: _states,
                                            onChanged: (States newValue) {
                                              setState(() {
                                                _city = selectCity;
                                                _cities = [selectCity];
                                                _states = newValue;
                                                _cities = data
                                                    .where((element) =>
                                                        element.state ==
                                                        newValue)
                                                    .toList();
                                              });
                                            },
                                            items: States.values
                                                .map((States classType) {
                                              return DropdownMenuItem<States>(
                                                  value: classType,
                                                  child: Text(stateValues
                                                      .reverse[classType]));
                                            }).toList()),
                                      ),
                                      _city == null || _cities.length == 0
                                          ? SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButtonFormField<
                                                      City>(
                                                  validator: (_) => _ == null
                                                      ? "Please Select City"
                                                      : null,
                                                  autovalidate: autoValidate,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: "City"),
                                                  isExpanded: true,
                                                  value: _city,
                                                  onChanged: (City newValue) {
                                                    setState(() {
                                                      _city = newValue;
                                                    });
                                                  },
                                                  items: _cities
                                                      .map((City classType) {
                                                    return DropdownMenuItem<
                                                            City>(
                                                        value: classType,
                                                        child: Text(
                                                            classType.city));
                                                  }).toList()),
                                            ),
                                      _textFormField(
                                          _pincode,
                                          "Pincode",
                                          (String _) => _.length == 6
                                              ? null
                                              : "Pincode should be of length 6",
                                          TextInputType.number),
                                      MaterialButton(
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          padding: EdgeInsets.all(8.0),
                                          onPressed: () async {
                                            setState(() {
                                              autoValidate = true;
                                            });
                                            if (_formKey.currentState
                                                .validate()) {
                                              CommonWidget.loading(context);
                                              UserSignUpModel _signUpData =
                                                  UserSignUpModel(
                                                      city: _city.city,
                                                      profileImage: _image
                                                          .readAsBytesSync(),
                                                      email: _email.text,
                                                      firstName:
                                                          _firstName.text,
                                                      lastName: _lastName.text+" ",
                                                      phoneNumber: widget
                                                              .arguments[
                                                          Strings.LOGIN_NUMBER],
                                                      pincode: _pincode.text);
                                              dynamic response = await API
                                                  .userSignUp(_signUpData);

                                              Navigator.pop(context);
                                              if (response is bool &&
                                                  response == false) {
                                                print("Error occurred");
                                              } else {
                                                Navigator.pushReplacementNamed(
                                                    context, Strings.HOMEPAGE);
                                              }
                                            }
                                          },
                                          child: Text(" Sign Up ",
                                              style: TextStyle(fontSize: 18.0)),
                                          shape: StadiumBorder(),
                                          color: Themes.DARK_BROWN_COOKIE,
                                          textColor: Colors.white)
                                    ])),
                          )))));
  }

  Widget _textFormField(TextEditingController controller, String label,
      Function validator, TextInputType textInputType) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            controller: controller,
            autovalidate: autoValidate,
            keyboardType: textInputType ?? TextInputType.text,
            validator: validator,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: label)));
  }
}

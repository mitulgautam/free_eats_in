import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeeatsin/core/model/city_model.dart';
import 'package:freeeatsin/core/model/profile_response_model.dart';
import 'package:freeeatsin/core/provider/user_provider.dart';
import 'package:freeeatsin/core/services/api.dart';
import 'package:freeeatsin/resources/themes.dart';
import 'package:freeeatsin/ui/widgets/common_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfileView extends StatefulWidget {
  final Map<String, String> arguments;
  final String firstName;
  final String lastName;
  final String city;
  final String state;
  final String email;
  final String address;
  final String banner;
  final String bio;

  const UpdateProfileView(
      {Key key,
      this.arguments,
      this.firstName,
      this.lastName,
      this.city,
      this.email,
      this.address,
      this.banner,
      this.state,
      this.bio});

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  bool autoValidate = false;
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _bio;
  TextEditingController _email;
  TextEditingController _pincode;
  String _stateError = "Please select state!";
  String _cityError = "Please select city!";
  File _image;
  StateAndCity data;
  bool _stateErrorStatus = false, _cityErrorStatus = false;

  @override
  void initState() {
    CommonWidget.loadCrosswordAsset("assets/images/cities.json").then((value) {
      data = StateAndCity.fromJson(json.decode(value));
      setState(() {
        //remove if else when fixed from backend
        context.read<UserProvider>().state =
            data.state.where((element) => element.name == widget.state).first;
        context.read<UserProvider>().city = context
            .read<UserProvider>()
            .state
            .cities
            .where((element) => element == widget.city)
            .first;
        isLoading = false;
      });
    });

    _firstName = TextEditingController(text: widget.firstName ?? "");
    _lastName = TextEditingController(text: widget.lastName ?? "");
    _email = TextEditingController(text: widget.email ?? "");
    _bio = TextEditingController(text: widget.bio ?? "");
    _pincode = TextEditingController(text: widget.address ?? "");
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
    return ChangeNotifierProvider.value(
      value: context.watch<UserProvider>(),
      child: Consumer<UserProvider>(
        builder: (_, model, __) => Scaffold(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                    _image = await ImagePicker
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    setState(() {});
                                                  },
                                                  child: DottedBorder(
                                                      dashPattern: [4, 8, 1],
                                                      color: Themes
                                                          .DARK_BROWN_COOKIE,
                                                      child: widget.banner !=
                                                                  null &&
                                                              _image == null
                                                          ? Image.network(
                                                              widget.banner,
                                                              fit: BoxFit.cover)
                                                          : Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: _image ==
                                                                      null
                                                                  ? Align(
                                                                      alignment: Alignment.center,
                                                                      child: Icon(
                                                                        Icons
                                                                            .image,
                                                                        color: Themes
                                                                            .DARK_BROWN_COOKIE,
                                                                      ))
                                                                  : SizedBox(width: MediaQuery.of(context).size.width / 3, height: MediaQuery.of(context).size.width / 3, child: Padding(padding: const EdgeInsets.all(8.0), child: Image.file(_image, fit: BoxFit.cover))))))),
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
                                          _textFormField(_bio, "Bio",
                                              (String _) => null, null),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButton<States>(
                                                  isExpanded: true,
                                                  value: model.state,
                                                  onChanged: (States newValue) {
                                                    model.city = null;
                                                    model.state = newValue;
                                                  },
                                                  items: data.state
                                                      .map((States state) {
                                                    return DropdownMenuItem<
                                                            States>(
                                                        value: state,
                                                        child:
                                                            Text(state.name));
                                                  }).toList())),
                                          _stateErrorStatus
                                              ? Text(_stateError,
                                                  style: TextStyle(
                                                      color: Colors.red))
                                              : SizedBox.shrink(),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  hint: Text("Select city"),
                                                  value: model.city == null
                                                      ? null
                                                      : model.city,
                                                  onChanged: (String newValue) {
                                                    model.city = newValue;
                                                  },
                                                  items: data.state
                                                      .where((element) =>
                                                          element.name ==
                                                          model.state.name)
                                                      .first
                                                      .cities
                                                      .map((String city) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: city,
                                                        child: Text(city));
                                                  }).toList())),
                                          _cityErrorStatus
                                              ? Text(_cityError,
                                                  style: TextStyle(
                                                      color: Colors.red))
                                              : SizedBox.shrink(),
                                          _textFormField(
                                              _pincode,
                                              "Address",
                                              (String _) => _.length > 3
                                                  ? null
                                                  : "Invalid address",
                                              null),
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
                                                if (model.city == null) {
                                                  setState(() {
                                                    _cityErrorStatus = true;
                                                  });
                                                }
                                                if (model.state == null) {
                                                  setState(() {
                                                    _stateErrorStatus = true;
                                                  });
                                                }
                                                if (_formKey.currentState
                                                        .validate() &&
                                                    !_cityErrorStatus &&
                                                    !_stateErrorStatus) {
                                                  setState(() {
                                                    _stateErrorStatus = false;
                                                    _cityErrorStatus = false;
                                                  });
                                                  CommonWidget.loading(context);
                                                  ProfileResponseModel
                                                      _signUpData =
                                                      ProfileResponseModel(
                                                          message: Message(
                                                              city: model.city,
                                                              address:
                                                                  _pincode.text,
                                                              email:
                                                                  _email.text,
                                                              bio: _bio.text,
                                                              state: model
                                                                  .state.name,
                                                              firstName:
                                                                  _firstName
                                                                      .text,
                                                              lastName:
                                                                  _lastName
                                                                      .text,
                                                              banner: _image ==
                                                                      null
                                                                  ? widget
                                                                      .banner
                                                                  : null));
                                                  bool response = await API
                                                      .updateUserProfile(
                                                          context
                                                              .read<
                                                                  UserProvider>()
                                                              .userLoginResponseModel
                                                              .message
                                                              .id,
                                                          _signUpData,
                                                          _image);
                                                  Navigator.pop(context);
                                                  if (response == false) {
                                                    print("Error occurred");
                                                  } else {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<UserProvider>()
                                                        .updateUserModel();
                                                  }
                                                }
                                              },
                                              child: Text(" Update ",
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                              shape: StadiumBorder(),
                                              color: Themes.DARK_BROWN_COOKIE,
                                              textColor: Colors.white)
                                        ])),
                              ))))),
      ),
    );
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

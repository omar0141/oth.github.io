// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shakosh/components/no_account_text.dart';
import 'package:shakosh/screens/sign_in/sign_in_screen.dart';
import 'package:shakosh/screens/sign_up/sign_up_screen.dart';
import 'package:shakosh/size_config.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../controller/login.dart';
import '../../../controller/phone_auth.dart';
import '../../../controller/social_auth.dart';
import '../../../helper/translation.dart';
import 'package:intl/intl.dart';

import '../../forgot_password/forgot_password_screen.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool? vfname;
  bool? vlname;
  bool? vemail;
  bool? vtel;
  bool? vpassword;
  bool terms = false;
  var mytoken;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final format = DateFormat("yyyy-MM-dd");

  Position? cl;

  GlobalKey<FormState> formstatesignup = GlobalKey();

  TextEditingController email = TextEditingController();

  TextEditingController tel = TextEditingController();

  TextEditingController password = TextEditingController();
  bool remember = false;
  bool show_email = true;
  bool show_tel = true;
  String country_code = '+20';

  String? validusername(String? val) {
    if (val!.trim().isEmpty) {
      return Translation.get("valid-username");
    }
    return null;
  }

  String? validtel(String? val) {
    if (val!.trim().isEmpty) {
      return Translation.get("valid-tel1");
    }
    return null;
  }

  String? validemail(String? val) {
    if (val!.trim().length < 4) {
      return Translation.get("valid-email2");
    }
    RegExp regex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    if (!regex.hasMatch(val)) {
      return Translation.get("valid-email2");
    }
    return null;
  }

  String? validpassword(String? val) {
    if (val!.trim().isEmpty) {
      return Translation.get("valid-password1");
    }
    if (val.trim().length < 4) {
      return Translation.get("valid-password2");
    }
    return null;
  }

  String? validretype_password(String? val) {
    if (val != password.text) {
      return Translation.get("valid-retype-password2");
    }
    return null;
  }

  @override
  void initState() {
    Provider.of<SocialAuth>(context, listen: false).social = false;
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        mytoken = token;
      });
      debugPrint(token.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool social = Provider.of<SocialAuth>(context, listen: false).social;
    String? facebook_id =
        Provider.of<SocialAuth>(context, listen: false).facebook_id;
    String google_id =
        Provider.of<SocialAuth>(context, listen: false).google_id;
    return Form(
      key: formstatesignup,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height * 0.15),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Translation.get('welcome'),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 34, 83),
                                    fontFamily: 'Circular'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Translation.get('hello-there-sign-in'),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 119, 133, 155),
                                    fontFamily: 'Circular'),
                              ),
                            ],
                          ),
                        ),
                        show_email == true
                            ? Container(
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      Translation.get("email"),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 119, 133, 155),
                                          fontFamily: 'Circular'),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        show_email == true
                            ? Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(child: buildEmailFormField()),
                                  ],
                                ),
                              )
                            : Container(),
                        show_email == true && show_tel == true ||
                                show_email == false && show_tel == false
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  Translation.get('or'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                ),
                              )
                            : Container(),
                        show_tel == true
                            ? Container(
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      Translation.get("tel"),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 119, 133, 155),
                                          fontFamily: 'Circular'),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        show_tel == true
                            ? Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(child: buildtelFormField()),
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Translation.get('password'),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 119, 133, 155),
                                    fontFamily: 'Circular'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(child: buildPasswordFormField()),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          alignment: AlignmentDirectional.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ForgotPasswordScreen.routeName);
                            },
                            child: Text(
                              Translation.get('forget-password'),
                              style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                  fontFamily: 'Circular'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        kPrimaryColor),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(vertical: 15)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    var formdata =
                                        formstatesignup.currentState!;
                                    if (formdata.validate()) {
                                      Provider.of<LoginC>(context,
                                              listen: false)
                                          .signin(context, password, email, tel,
                                              country_code, mytoken);
                                    }
                                  },
                                  child: Text(
                                    Translation.get('sign-in'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Circular',
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Translation.get('sign-in-make-account'),
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(16),
                                    /*  color: Color.fromARGB(255, 120, 161, 233)*/
                                    color: kPrimaryColor),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, SignUpScreen.routeName),
                                child: Text(
                                  Translation.get('sign-up'),
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(16),
                                      color:
                                          Color.fromARGB(255, 120, 161, 233)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.32),
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        validator: validemail,
        controller: email,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          RegExp regex =
              RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
          if (e.trim().length < 4) {
            vemail = false;
          } else if (!regex.hasMatch(e)) {
            vemail = false;
          } else {
            vemail = true;
          }
          if (e.isNotEmpty) {
            setState(() {
              show_tel = false;
            });
          } else if (e.isEmpty) {
            setState(() {
              show_tel = true;
            });
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vemail == false
                    ? Colors.red
                    : vemail == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vemail == false
                      ? Icons.close
                      : vemail == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }

  TextFormField buildtelFormField() {
    return TextFormField(
        validator: validtel,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: tel,
        onChanged: (e) {
          if (e == '') {
            vtel = false;
          }
          if (e.isNotEmpty) {
            vtel = true;
          }
          if (e.isNotEmpty) {
            setState(() {
              show_email = false;
            });
          } else if (e.isEmpty) {
            setState(() {
              show_email = true;
            });
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            prefixIcon: CountryCodePicker(
              onChanged: (e) {
                country_code = e.dialCode.toString();
              },
              initialSelection: 'EG',
              favorite: const ['+20', 'EG'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vtel == false
                    ? Colors.red
                    : vtel == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vtel == false
                      ? Icons.close
                      : vtel == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        validator: validpassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: true,
        controller: password,
        onChanged: (e) {
          if (e == '' || e.length < 6) {
            vpassword = false;
          } else {
            vpassword = true;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vpassword == false
                    ? Colors.red
                    : vpassword == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vpassword == false
                      ? Icons.close
                      : vpassword == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }
}

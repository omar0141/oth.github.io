// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shakosh/constants.dart';
import 'package:shakosh/size_config.dart';
import 'package:provider/provider.dart';
import '../../../controller/change_password.dart';
import '../../../helper/translation.dart';
import 'change_password_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool? vpassword;
  bool? vretype_password;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController password = TextEditingController();
  TextEditingController retype_password = TextEditingController();
  String? validpassword(String? val) {
    if (val!.trim().isEmpty) {
      return Translation.get("valid-password1");
    }
    if (val.trim().length < 6) {
      return Translation.get("valid-password2");
    }
    return null;
  }

  String? validretype_password(String? val) {
    if (val != password.text) {
      return Translation.get("valid-retype-password");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formstate,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height * 0.15),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
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
                              Translation.get('hello-there-reset-password'),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get("password"),
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
                            Expanded(child: buildpasswordFormField()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get("retype-password"),
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
                            Expanded(child: buildretype_passwordFormField()),
                          ],
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
                                  backgroundColor:
                                      MaterialStateProperty.all(kPrimaryColor),
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
                                onPressed: (() async {
                                  var formdata = formstate.currentState!;
                                  if (formdata.validate()) {
                                    Provider.of<ChangePasswordC>(context,
                                            listen: false)
                                        .change_password(context, password);
                                  }
                                }),
                                child: Text(
                                  Translation.get("continue"),
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
        ),
      ),
    );
  }

  TextFormField buildpasswordFormField() {
    return TextFormField(
        validator: validpassword,
        obscureText: true,
        controller: password,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          if (e == '') {
            vpassword = false;
          }
          if (e.isNotEmpty) {
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

  TextFormField buildretype_passwordFormField() {
    return TextFormField(
        validator: validretype_password,
        obscureText: true,
        controller: retype_password,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          if (e == '') {
            vretype_password = false;
          }
          if (e.isNotEmpty) {
            vretype_password = true;
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
                backgroundColor: vretype_password == false
                    ? Colors.red
                    : vretype_password == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vretype_password == false
                      ? Icons.close
                      : vretype_password == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }
}

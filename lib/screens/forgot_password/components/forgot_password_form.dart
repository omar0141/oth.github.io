// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'package:shakosh/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/components/default_button.dart';
import 'package:shakosh/controller/reset_password.dart';
import 'package:provider/provider.dart';
import '../../../controller/phone_auth.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  var mytoken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retype_password = TextEditingController();
  TextEditingController smscode = TextEditingController();
  String country_code = '+20';
  bool show_email = true;
  bool show_tel = true;

  String? validemail(String val) {
    if (val.trim().length < 4) {
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
    return Form(
      key: formstate,
      child: Column(
        children: [
          show_email == true ? buildEmailFormField() : Container(),
          show_email == true
              ? SizedBox(height: getProportionateScreenHeight(30))
              : Container(),
          show_tel == true ? buildtelFormField() : Container(),
          show_tel == true
              ? SizedBox(height: getProportionateScreenHeight(30))
              : Container(),
          show_tel == true ? buildPasswordFormField() : Container(),
          show_tel == true
              ? SizedBox(height: getProportionateScreenHeight(30))
              : Container(),
          show_tel == true ? buildretype_passwordFormField() : Container(),
          show_tel == true
              ? SizedBox(height: getProportionateScreenHeight(30))
              : Container(),
          DefaultButton(
            text: Translation.get("reset"),
            press: () {
              var formdata = formstate.currentState!;
              if (formdata.validate()) {
                if (show_tel == true) {
                  Provider.of<PhoneAuthc>(context, listen: false).phoneauth(
                      context,
                      country_code,
                      tel,
                      smscode,
                      '',
                      '',
                      '',
                      '',
                      email,
                      password,
                      '',
                      mytoken,
                      '',
                      true,
                      false,
                      '');
                  setState(() {});
                } else {
                  Provider.of<ResetPasswordC>(context, listen: false)
                      .reset(country_code, tel, password, context, email);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildtelFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (e) {
        if (e.isNotEmpty) {
          setState(() {
            show_email = false;
          });
        } else if (e.isEmpty) {
          setState(() {
            show_email = true;
          });
        }
      },
      controller: tel,
      decoration: InputDecoration(
        labelText: Translation.get("tel"),
        hintText: Translation.get("enter-tel"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.phone,
          color: Colors.grey,
        ),
        prefixIcon: CountryCodePicker(
          onChanged: (e) {
            country_code = e.dialCode.toString();
          },
          initialSelection: 'EG',
          favorite: ['+20', 'EG'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
        ),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      validator: validpassword,
      controller: password,
      decoration: InputDecoration(
        labelText: Translation.get("password"),
        hintText: Translation.get("enter-password"),
        suffixIcon: Icon(
          Icons.lock_outlined,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildretype_passwordFormField() {
    return TextFormField(
      obscureText: true,
      validator: validretype_password,
      controller: retype_password,
      decoration: InputDecoration(
        labelText: Translation.get("retype-password"),
        hintText: Translation.get("enter-retype-password"),
        suffixIcon: Icon(
          Icons.lock_outlined,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField smscodeFormField() {
    return TextFormField(
      controller: smscode,
      decoration: InputDecoration(
        labelText: Translation.get("verfication-code"),
        hintText: Translation.get("enter-verfication-code"),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (e) {
        if (e.isNotEmpty) {
          setState(() {
            show_tel = false;
          });
        } else if (e.isEmpty) {
          setState(() {
            show_tel = true;
          });
        }
      },
      controller: email,
      decoration: InputDecoration(
        labelText: Translation.get("email"),
        hintText: Translation.get("enter-email"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.email_outlined,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
    );
  }
}

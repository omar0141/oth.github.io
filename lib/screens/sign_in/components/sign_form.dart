// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, prefer_const_literals_to_create_immutables
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/controller/login.dart';
import 'package:shakosh/controller/social_auth.dart';
import 'package:shakosh/screens/forgot_password/forgot_password_screen.dart';
import 'package:provider/provider.dart';
import '../../../components/default_button.dart';
import '../../../components/socal_card.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shakosh/constants.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  var mytoken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  GlobalKey<FormState> formstatesignin = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();
  String country_code = '+20';
  bool remember = false;
  bool show_email = true;
  bool show_tel = true;

  String? validtel(String val) {
    if (val.trim().isEmpty) {
      return Translation.get("valid-tel1");
    }
    if (val.trim().length < 11) {
      return Translation.get("valid-tel2");
    }
    if (val.trim().length > 12) {
      return Translation.get("valid-tel2");
    }
    return null;
  }

  String? validemail(String val) {
    if (val.trim().isEmpty) {
      return Translation.get("valid-email1");
    }
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
      key: formstatesignin,
      child: Column(
        children: [
          show_email == true ? buildemailFormField() : Container(),
          show_email == true
              ? SizedBox(height: getProportionateScreenHeight(10))
              : Container(),
          show_email == true && show_tel == true ||
                  show_email == false && show_tel == false
              ? Text(
                  'Or',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              : Container(),
          show_email == true
              ? SizedBox(height: getProportionateScreenHeight(20))
              : Container(),
          show_tel == true ? buildtelFormField() : Container(),
          show_tel == true
              ? SizedBox(height: getProportionateScreenHeight(30))
              : Container(),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            alignment: AlignmentDirectional.center,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
              },
              child: Text(
                Translation.get('forget-password'),
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: Translation.get('sign-in-button'),
            press: () {
              var formdata = formstatesignin.currentState!;
              if (formdata.validate()) {
                Provider.of<LoginC>(context, listen: false).signin(
                    context, password, email, tel, country_code, mytoken);
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocalCard(
                icon: "assets/icons/google-icon.svg",
                press: () async {
                  await Provider.of<SocialAuth>(context, listen: false)
                      .signInWithGoogle(context, password, email, tel, '', '',
                          country_code, mytoken, false, true);
                },
              ),
              SocalCard(
                icon: "assets/icons/facebook-2.svg",
                press: () async {
                  await Provider.of<SocialAuth>(context, listen: false)
                      .signInWithFacebook(context, password, email, tel, '', '',
                          country_code, mytoken, false, true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: password,
      validator: validpassword,
      decoration: InputDecoration(
        labelText: Translation.get('password'),
        hintText: Translation.get('enter-password'),
        suffixIcon: Icon(
          Icons.lock_outlined,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: kPrimaryColor),
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

  TextFormField buildemailFormField() {
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

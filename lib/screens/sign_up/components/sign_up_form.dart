// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors, avoid_print

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shakosh/components/default_button.dart';
import 'package:shakosh/constants.dart';
import 'package:shakosh/controller/phone_auth.dart';
import 'package:provider/provider.dart';
import '../../../components/socal_card.dart';
import '../../../controller/social_auth.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var mytoken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final format = DateFormat("yyyy-MM-dd");
  Position? cl;
  GlobalKey<FormState> formstatesignup = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retype_password = TextEditingController();
  TextEditingController smscode = TextEditingController();
  String? gender = '';
  DateTime? mydate;
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocalCard(
                icon: "assets/icons/google-icon.svg",
                press: () async {
                  await Provider.of<SocialAuth>(context, listen: false)
                      .signInWithGoogle(
                          context,
                          password,
                          email,
                          tel,
                          firstname,
                          lastname,
                          country_code,
                          mytoken,
                          true,
                          false);
                  setState(() {});
                },
              ),
              SocalCard(
                icon: "assets/icons/facebook-2.svg",
                press: () async {
                  await Provider.of<SocialAuth>(context, listen: false)
                      .signInWithFacebook(
                          context,
                          password,
                          email,
                          tel,
                          firstname,
                          lastname,
                          country_code,
                          mytoken,
                          true,
                          false);
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            children: [
              Expanded(flex: 1, child: buildfirstnameFormField()),
              SizedBox(width: getProportionateScreenWidth(10)),
              Expanded(flex: 1, child: buildlastnameFormField()),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildtelFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          (social == false ? buildPasswordFormField() : Container()),
          (social == false
              ? SizedBox(height: getProportionateScreenHeight(30))
              : Container()),
          (social == false ? buildretype_passwordFormField() : Container()),
          (social == false
              ? SizedBox(height: getProportionateScreenHeight(30))
              : Container()),
          buildGenderDropdown(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: Translation.get("sign-up-button"),
            press: () {
              var formdata = formstatesignup.currentState!;
              if (formdata.validate()) {
                Provider.of<PhoneAuthc>(context, listen: false).phoneauth(
                    context,
                    country_code,
                    tel,
                    smscode,
                    google_id,
                    facebook_id,
                    firstname,
                    lastname,
                    email,
                    password,
                    gender,
                    mytoken,
                    mydate,
                    false,
                    false,
                    '');
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildfirstnameFormField() {
    return TextFormField(
      validator: validusername,
      controller: firstname,
      decoration: InputDecoration(
        labelText: Translation.get("firstname"),
        hintText: Translation.get("enter-firstname"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildlastnameFormField() {
    return TextFormField(
      validator: validusername,
      controller: lastname,
      decoration: InputDecoration(
        labelText: Translation.get("lastname"),
        hintText: Translation.get("enter-lastname"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildtelFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: validtel,
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
          favorite: const ['+20', 'EG'],
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: email,
      validator: validemail,
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

  DropdownButtonFormField buildGenderDropdown() {
    return DropdownButtonFormField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            gender = value;
          });
        }
        return null;
      },
      value: '',
      isExpanded: true,
      decoration: InputDecoration(
        labelText: Translation.get('gender'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      items: [
        DropdownMenuItem(
          value: '',
          child: Text(Translation.get('not-say')),
        ),
        DropdownMenuItem(
          value: "male",
          child: Text(Translation.get('male')),
        ),
        DropdownMenuItem(
          value: "female",
          child: Text(Translation.get('female')),
        ),
      ],
    );
  }
}

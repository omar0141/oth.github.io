// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakosh/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shakosh/components/default_button.dart';
import 'package:shakosh/controller/edit_profile.dart';
import 'package:shakosh/controller/phone_auth.dart';
import 'package:shakosh/controller/social_auth.dart';
import 'package:provider/provider.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';
import 'package:intl/intl.dart';

class edit_profileForm extends StatefulWidget {
  const edit_profileForm({Key? key}) : super(key: key);

  @override
  _edit_profileFormState createState() => _edit_profileFormState();
}

class _edit_profileFormState extends State<edit_profileForm> {
  var mytoken;
  final format = DateFormat("yyyy-MM-dd");
  Position? cl;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retype_password = TextEditingController();
  TextEditingController smscode = TextEditingController();
  String? gender = '';
  String gender_val = '';
  String country_code = '+20';
  String? phone = '';
  String google_id = '';
  String? facebook_id = '';
  TextEditingController date_val = TextEditingController();
  DateTime? mydate;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  bool auth = false;

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

  getData() async {
    date_val.text = formatter.format(DateTime.now()).toString();
    await Provider.of<EditProfileC>(context, listen: false)
        .getData(firstname, lastname, email, tel, date_val, formatter);
    facebook_id = Provider.of<EditProfileC>(context, listen: false).facebook_id;
    google_id = Provider.of<EditProfileC>(context, listen: false).google_id;
    gender = Provider.of<EditProfileC>(context, listen: false).gender;
    phone = Provider.of<EditProfileC>(context, listen: false).phone;
    gender_val = Provider.of<EditProfileC>(context, listen: false).gender_val;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formstate,
      child: Column(
        children: [
          Wrap(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.09)),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: (() async {
                  if (google_id == '') {
                    await Provider.of<SocialAuth>(context, listen: false)
                        .signInWithGoogle(
                            context,
                            password,
                            email,
                            tel,
                            firstname,
                            firstname,
                            country_code,
                            mytoken,
                            false,
                            false);
                    google_id = Provider.of<SocialAuth>(context, listen: false)
                        .google_id;
                    setState(() {});
                  } else {
                    google_id = '';
                    setState(() {});
                  }
                }),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/icons/google-icon.svg"),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      google_id == ''
                          ? Translation.get('connect')
                          : Translation.get('disconnect'),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.09)),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: (() async {
                  if (facebook_id == '') {
                    await Provider.of<SocialAuth>(context, listen: false)
                        .signInWithFacebook(
                            context,
                            password,
                            email,
                            tel,
                            firstname,
                            firstname,
                            country_code,
                            mytoken,
                            false,
                            false);
                    facebook_id =
                        Provider.of<SocialAuth>(context, listen: false)
                            .facebook_id;
                    setState(() {});
                  } else {
                    facebook_id = '';
                    setState(() {});
                  }
                }),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/icons/facebook-2.svg"),
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      facebook_id == ''
                          ? Translation.get('connect')
                          : Translation.get('disconnect'),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
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
          buildGenderDropdown(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: Translation.get("edit-profile"),
            press: () async {
              var formdata = formstate.currentState!;
              if (formdata.validate()) {
                if (auth == false) {
                  await Provider.of<EditProfileC>(context, listen: false)
                      .change_profile(context, firstname, lastname, email, tel,
                          mydate, google_id, facebook_id, '');
                } else {
                  Provider.of<PhoneAuthc>(context, listen: false).phoneauth(
                      context,
                      country_code,
                      tel,
                      smscode,
                      google_id,
                      facebook_id,
                      firstname,
                      firstname,
                      email,
                      password,
                      gender,
                      mytoken,
                      mydate,
                      false,
                      true,
                      '');
                }
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
      onChanged: (e) {
        debugPrint(phone.toString());
        debugPrint(e.toString());
        if (phone == e) {
          auth = false;
        } else {
          auth = true;
        }

        setState(() {});
      },
      decoration: InputDecoration(
        labelText: Translation.get("tel"),
        hintText: Translation.get("enter-tel"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.phone,
          color: Colors.grey,
        ),
        prefixIcon: auth == true
            ? CountryCodePicker(
                onChanged: (e) {
                  country_code = e.dialCode.toString();
                },
                initialSelection: 'EG',
                favorite: const ['+20', 'EG'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
              )
            : null,
        labelStyle: const TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField smscodeFormField() {
    return TextFormField(
      textAlign: TextAlign.right,
      controller: smscode,
      decoration: InputDecoration(
        labelText: Translation.get("verfication-code"),
        hintText: Translation.get("enter-verfication-code"),
        labelStyle: const TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: validemail,
      controller: email,
      decoration: InputDecoration(
        labelText: Translation.get("email"),
        hintText: Translation.get("enter-email"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.email_outlined,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
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
      value: gender_val,
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

// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:shakosh/constants.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/components/default_button.dart';
import 'package:shakosh/controller/change_password.dart';
import 'package:provider/provider.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  var mytoken;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController password = TextEditingController();
  TextEditingController retype_password = TextEditingController();

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
  Widget build(BuildContext context) {
    return Form(
      key: formstate,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildretype_passwordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: Translation.get("change"),
            press: () {
              var formdata = formstate.currentState!;
              if (formdata.validate()) {
                Provider.of<ChangePasswordC>(context, listen: false)
                    .change_password(context, password);
              }
            },
          ),
        ],
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
}

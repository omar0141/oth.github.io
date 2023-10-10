import 'package:flutter/material.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Config/Utils/Validator.dart';
import 'package:shakosh/new/components/default_button.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formstate,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  screenWidth > 768
                      ? "sign-in".tr
                      : "sign-in-with-your-data".tr,
                  style: TextStyle(
                      color: screenWidth > 768 ? null : colors(context).grey1,
                      fontWeight: screenWidth > 768 ? FontWeight.bold : null,
                      fontSize: mySize(16, 16, 22, 22, 22)),
                ),
              ],
            ),
            SizedBox(
              height: mySize(40, 40, 20, 20, 20),
            ),
            textField(
                phone, "tel".tr, false, Icons.call, Validators().validEmpty),
            SizedBox(
              height: 20,
            ),
            textField(password, "password".tr, true, Icons.lock,
                Validators().validPassword),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 65,
              child: DefaultButton(
                fontsize: 18,
                text: "sign-in".tr,
                press: () {
                  var formdata = formstate.currentState!;
                  if (formdata.validate()) {
                    print("object");
                  }
                },
              ),
            )
          ],
        ));
  }

  TextFormField textField(controller, text, secure, icon, validation) {
    return TextFormField(
      controller: controller,
      obscureText: secure,
      validator: validation,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(prefixIcon: Icon(icon), label: Text(text)),
    );
  }
}

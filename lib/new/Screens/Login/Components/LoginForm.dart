import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/User/user_bloc.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Config/Utils/Validator.dart';
import 'package:shakosh/new/components/default_button.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey<FormState> formstate;
  @override
  void initState() {
    formstate = GlobalKey();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController phone = BlocProvider.of<UserBloc>(context).phoneLogin;
    TextEditingController password =
        BlocProvider.of<UserBloc>(context).passwordLogin;
    //
    return Form(
        key: formstate,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: screenWidth > 768
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
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
              height: 20,
            ),
            textField(
                phone, "tel".tr, false, Icons.call, Validators().validPhone),
            SizedBox(
              height: 20,
            ),
            textField(password, "password".tr, true, Icons.lock,
                Validators().validPassword),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 55,
              child:
                  BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                if (state is SubmitLoadingState) {
                  return DefaultButton(
                    fontsize: 18,
                    text: "sign-in".tr,
                    submit: true,
                    press: () {},
                  );
                } else {
                  return DefaultButton(
                    fontsize: 18,
                    text: "sign-in".tr,
                    press: () {
                      var formdata = formstate.currentState!;
                      if (formdata.validate()) {
                        BlocProvider.of<UserBloc>(context).add(LoginEvent(
                            password: password.text, username: phone.text));
                      }
                    },
                  );
                }
              }),
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

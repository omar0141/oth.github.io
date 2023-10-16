import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/User/user_bloc.dart';
import 'package:shakosh/new/Components/LoadingDropDown.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Config/Utils/Validator.dart';
import 'package:shakosh/new/Data/Models/UserModel.dart';
import 'package:shakosh/new/components/default_button.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

// ignore: must_be_immutable
class EditProfileForm extends StatefulWidget {
  EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late GlobalKey<FormState> formstate;
  TextEditingController phone = TextEditingController();
  TextEditingController username = TextEditingController();
  @override
  void initState() {
    formstate = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoadedState) {
          UserModel user = BlocProvider.of<UserBloc>(context).user;
          phone.text = user.telephone ?? "";
          username.text = user.firstName ?? "";
        }
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
                          ? "edit-profile".tr
                          : "edit-profile-with-your-new-data".tr,
                      style: TextStyle(
                          color:
                              screenWidth > 768 ? null : colors(context).grey1,
                          fontWeight:
                              screenWidth > 768 ? FontWeight.bold : null,
                          fontSize: mySize(16, 16, 22, 22, 22)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                (state is LoadingState)
                    ? loadingInput()
                    : textField(username, "username".tr, false, Icons.person,
                        Validators().validEmpty),
                SizedBox(
                  height: 20,
                ),
                (state is LoadingState)
                    ? loadingInput()
                    : textField(phone, "tel".tr, false, Icons.call,
                        Validators().validPhone),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 55,
                    child: DefaultButton(
                      fontsize: 18,
                      text: "save".tr,
                      submit: (state is SubmitLoadingState) ? true : false,
                      press: () {
                        if (state is SubmitLoadingState) {
                        } else {
                          var formdata = formstate.currentState!;
                          if (formdata.validate()) {
                            BlocProvider.of<UserBloc>(context).add(
                                UpdateUserData(
                                    username: username.text, tel: phone.text));
                          }
                        }
                      },
                    ))
              ],
            ));
      },
    );
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

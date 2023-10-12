import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/User/user_bloc.dart';
import 'package:shakosh/new/Components/LoadingDropDown.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Config/Utils/Validator.dart';
import 'package:shakosh/new/components/default_button.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';

// ignore: must_be_immutable
class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formstate = GlobalKey();
    TextEditingController phone =
        BlocProvider.of<UserBloc>(context).phoneRegister;
    TextEditingController password =
        BlocProvider.of<UserBloc>(context).passwordRegister;
    TextEditingController username =
        BlocProvider.of<UserBloc>(context).usernameRegister;
    TextEditingController address =
        BlocProvider.of<UserBloc>(context).addressRegister;
    String cityId = BlocProvider.of<UserBloc>(context).cityId;
    String areaId = BlocProvider.of<UserBloc>(context).areaId;
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
                      ? "sign-up".tr
                      : "it-only-takes-a-minute-to-create-your-account".tr,
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
            textField(username, "username".tr, false, Icons.person,
                Validators().validEmpty),
            SizedBox(
              height: 20,
            ),
            textField(
                phone, "tel".tr, false, Icons.call, Validators().validPhone),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<DependanciesBloc, DependanciesState>(
                builder: (context, state) {
              if (state is DependanciesLoading) {
                return Row(
                  children: [
                    Expanded(child: loadingInput()),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: loadingInput()),
                  ],
                );
              } else if (state is DependanciesLoaded) {
                return Row(
                  children: [
                    Expanded(
                        child: dropDown(
                      state.dependantsData!.cities!,
                      "select-city".tr,
                      context,
                      onChange: (value) {
                        cityId = value;
                      },
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: dropDown(
                      state.dependantsData!.areas!,
                      "select-area".tr,
                      context,
                      onChange: (value) {
                        areaId = value;
                      },
                    )),
                  ],
                );
              } else {
                return Container();
              }
            }),
            SizedBox(
              height: 20,
            ),
            textField(address, "address".tr, false, Icons.location_on,
                Validators().validEmpty),
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
                    text: "sign-up".tr,
                    submit: true,
                    press: () {},
                  );
                } else {
                  return DefaultButton(
                    fontsize: 18,
                    text: "sign-up".tr,
                    press: () {
                      var formdata = formstate.currentState!;
                      if (formdata.validate()) {
                        BlocProvider.of<UserBloc>(context).add(RegisterEvent(
                            password: password.text,
                            username: username.text,
                            address: address.text,
                            tel: phone.text,
                            cityId: cityId,
                            areaId: areaId));
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

  dropDown(List items, text, context,
      {required Function(String value) onChange}) {
    return DropdownButtonFormField(
        padding: EdgeInsets.all(0),
        value: "",
        isExpanded: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => Validators().validEmpty(value.toString()),
        decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
        ),
        items: [
          DropdownMenuItem(
              value: "",
              child: Text(
                text,
                style: TextStyle(
                    color: colors(context).kprimaryColor!.withOpacity(0.7)),
              )),
          for (var item in items)
            DropdownMenuItem(
                value: item.id,
                child: Text(
                  "language_iso".tr == "ar" ? item.nameAlt : item.name,
                  style: TextStyle(fontSize: 14),
                  maxLines: 1,
                )),
        ],
        onChanged: (value) => onChange(value.toString()));
  }
}

// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:shakosh/controller/register.dart';
import 'package:shakosh/controller/reset_password.dart';
import 'package:provider/provider.dart';
import '../components/loading.dart';
import '../constants.dart';
import '../helper/translation.dart';
import '../size_config.dart';
import 'edit_profile.dart';

class PhoneAuthc with ChangeNotifier {
  bool verified = false;

  phoneauth(
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
      reset,
      edit_profile,
      apple_id) async {
    Loading().showloading(context);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${country_code}${tel.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          verified = true;
          if (reset == true) {
            await Provider.of<ResetPasswordC>(context, listen: false)
                .reset(country_code, tel, password, context, email);
          }
          if (edit_profile == true) {
            await Provider.of<EditProfileC>(context, listen: false)
                .change_profile(context, firstname, lastname, email, tel,
                    mydate, google_id, facebook_id, apple_id);
          }
          if (edit_profile == false && reset == false) {
            await Provider.of<RegisterC>(context, listen: false).signup(
                context,
                google_id,
                facebook_id,
                firstname,
                lastname,
                email,
                country_code,
                tel,
                password,
                gender,
                mydate,
                mytoken,
                verified,
                apple_id);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.toString());
          AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.ERROR,
            title: Translation.get("error"),
            desc: Translation.get("sign-up-tel-valid") + e.toString(),
            btnOkColor: Colors.red,
            btnOkText: Translation.get("ok"),
            btnOkOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        },
        codeSent: (String verficationId, int? resendToken) {
          AwesomeDialog(
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.INFO_REVERSED,
              title: Translation.get("verfication-code"),
              body: Column(
                children: [
                  TextFormField(
                    controller: smscode,
                    decoration: InputDecoration(
                      labelText: Translation.get("verfication-code"),
                      hintText: Translation.get("enter-verfication-code"),
                      labelStyle: const TextStyle(color: kPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                ],
              ),
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnCancelText: Translation.get("cancel"),
              btnOkText: Translation.get("ok"),
              btnOkOnPress: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verficationId, smsCode: smscode.text);
                try {
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  verified = true;
                  smscode.text = '';
                  if (reset == true) {
                    await Provider.of<ResetPasswordC>(context, listen: false)
                        .reset(country_code, tel, password, context, email);
                  }
                  if (edit_profile == true) {
                    await Provider.of<EditProfileC>(context, listen: false)
                        .change_profile(context, firstname, lastname, email,
                            tel, mydate, google_id, facebook_id, apple_id);
                  }
                  if (edit_profile == false && reset == false) {
                    await Provider.of<RegisterC>(context, listen: false).signup(
                        context,
                        google_id,
                        facebook_id,
                        firstname,
                        lastname,
                        email,
                        country_code,
                        tel,
                        password,
                        gender,
                        mydate,
                        mytoken,
                        verified,
                        apple_id);
                  }
                } on FirebaseAuthException catch (e) {
                  final snackBar = SnackBar(content: Text(e.message!));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                }
              }).show();
        },
        codeAutoRetrievalTimeout: (String verficationId) {},
        timeout: const Duration(seconds: 60));
  }
}

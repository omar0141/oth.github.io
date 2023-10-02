// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shakosh/controller/MyApi.dart';
import 'package:shakosh/controller/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuth with ChangeNotifier {
  String google_id = '';
  String? apple_id = '';
  String? facebook_id = '';
  String? social_email = '';
  String? social_name = '';
  bool social = false;

  Future<UserCredential> signInWithGoogle(context, password, email, tel,
      firstname, lastname, country_code, mytoken, signup, signin) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await (GoogleSignIn().signIn());

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    google_id = googleUser.id;
    social_email = googleUser.email;
    social_name = googleUser.displayName;
    social = true;
    if (signup == true) {
      email.text = googleUser.email;
      firstname.text = googleUser.displayName;
    }

    if (signin == true) {
      Provider.of<LoginC>(context, listen: false)
          .signin(context, password, email, tel, country_code, mytoken);
    }

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook(context, password, email, tel,
      firstname, lastname, country_code, mytoken, signup, signin) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    var graphResponse = await http
        .get(Uri.parse(MyApi.facebook + loginResult.accessToken!.token));

    var profile = json.decode(graphResponse.body);
    facebook_id = profile['id'];
    social_email = profile['email'];
    social_name = profile['name'];
    social = true;
    if (signup == true) {
      email.text = profile['email'];
      firstname.text = profile['name'];
    }
    if (signin == true) {
      Provider.of<LoginC>(context, listen: false)
          .signin(context, password, email, tel, country_code, mytoken);
    }
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple(context, password, email, tel,
      firstname, lastname, country_code, mytoken, signup, signin) async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    apple_id = appleCredential.identityToken;
    social_name = appleCredential.givenName ?? '';
    social_email = appleCredential.email ?? '';
    social = true;
    if (signup == true) {
      email.text = appleCredential.email;
      firstname.text = appleCredential.givenName;
    }

    if (signin == true) {
      Provider.of<LoginC>(context, listen: false)
          .signin(context, password, email, tel, country_code, mytoken);
    }

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}

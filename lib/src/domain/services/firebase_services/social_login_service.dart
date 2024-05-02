import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';


class SocialLogin {
  static SocialLogin get instance {
    return SocialLogin();
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      clientId: Platform.isIOS
          ? "476620447214-lbkt1joiqjpiaqt7c5m9c1b77lkm7qlu.apps.googleusercontent.com"
          : "",
      scopes: [
        'email',
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    ).signIn();
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  // Future<UserCredential> signInWithFacebook() async {
  //
  // }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }



  signOut() async {
    switch (FirebaseAuth.instance.currentUser?.providerData[0].providerId
        .toString()) {
      case "facebook.com":
        break;
      case "google.com":
        try {
          await GoogleSignIn().disconnect();
        } catch (ex) {

        }
        break;
    }
    await FirebaseAuth.instance.signOut();

    // }
  }

  socialSignOut() async {
    switch (FirebaseAuth.instance.currentUser?.providerData[0].providerId
        .toString()) {
      case "facebook.com":
        break;
      case "google.com":
        try {
          await GoogleSignIn().disconnect();
        } catch (ex) {

        }
        break;
    }
    await FirebaseAuth.instance.signOut();
  }
}

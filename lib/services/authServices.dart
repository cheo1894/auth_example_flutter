import 'dart:developer';

import 'package:auth_flutter_example/models/userModel.dart';
import 'package:auth_flutter_example/services/servicesMixin.dart';
import 'package:auth_flutter_example/widgets/myText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Authservices with Servicesmixin {
  Future createUser(
      {String email = '', String password = '', required BuildContext context}) async {
    try {
      final credential =
          await auth.createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
          id: credential.user!.uid,
          registerMethod: 'E&P',
          createdAt: DateTime.now().toString(),
          email: email);

      return await firestore.collection('users').doc(user.id).set(user.toJson()).then(
        (value) {
          return user;
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MyText(
          text: 'The password provided is too weak.',
        )));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MyText(
          text: 'The account already exists for that email.',
        )));
      }
    } catch (e) {
      print(e);
    }
  }

  Future loginWithEmailAndPassword({String email = '', String password = ''}) async {
    UserModel? user;
    try {
      var credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      log(credential.user.toString());
      if (credential.user != null) {
        var response = await firestore.collection('users').doc(credential.user!.uid).get();

        if (response.data() != null) {
          user = UserModel.fromJson(response.data()!);
        }
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signInWithGoogle() async {
    try {
      UserModel? user;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user?.uid != null) {
        String userId = userCredential.user!.uid;

        DocumentSnapshot<Map<String, dynamic>> res =
            await firestore.collection('users').doc(userId).get();

        if (res.exists) {
          user = UserModel.fromJson(res.data()!);
          return user;
        } else {
          UserModel user = UserModel(
              id: userId,
              registerMethod: 'Google',
              createdAt: DateTime.now().toString(),
              email: userCredential.user!.email!);

          await firestore.collection('users').doc(userId).set(user.toJson());
          return user;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future signWithApple(BuildContext context) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);

      final oAuthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken, accessToken: appleCredential.authorizationCode);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
    } catch (e) {
      print('Error with Apple sign in: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: MyText(
        text: 'Error with Apple sign in: $e',
      )));
    }
  }

  Future signOut(BuildContext context, UserModel user) async {
    try {
      user.updatedAt = DateTime.now().toString();

      await firestore.collection('users').doc(user.id).set(user.toJson()).then(
        (value) async {
          await auth.signOut().then(
            (value) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (value) {
                  return false;
                },
              );
            },
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}

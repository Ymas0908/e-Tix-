import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pages/home/home.dart';
import '../pages/login/login.dart';
import '../pages/resetpassword/resetpassaword.dart';

class AuthService {
  Future<void> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Home()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Le mot de passe est trop faible.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Un compte existe déjà avec cette adresse email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {}
  }

  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Home()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'Aucun compte n\'est associe à cette adresse email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Mot de passe invalide.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {}
  }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await Future.delayed(const Duration(seconds: 1));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Login(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'Aucun compte n\'est associe à cette adresse email.';
      }
    } catch (e) {
      print(e);
    }
  }
}

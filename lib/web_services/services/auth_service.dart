import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../views/home/home.dart';
import '../../views/login/login.dart';


class AuthService {

  /***
   * Methode pour s'inscrire
   */
  Future<void> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) =>  Home()));
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
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: 'Une erreur est survenue lors de l\'inscription.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }


  /***
   * Methode pour se connecter
   */

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Utilisateur non trouvé') {
        print('Utilisateur non trouve pour cet email.');
      } else if (e.code == 'Mot de passe incorrect') {
        print('Mot de passe incorrect fourni pour cet utilisateur');
      }
    }
  }


  /***
   * Methode pour se deconnecter
   */
  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }


  /***
   * Methode pour réinitialiser le mot de passe par email
   */
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

  Future<void> signout2({required BuildContext context}) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) => null,);
    await Future.delayed(const Duration(seconds: 1));
  }







}

import 'package:flutter/material.dart';
import '../web_services/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthService authService;

  User? get user => FirebaseAuth.instance.currentUser;

  AuthViewModel({required this.authService});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signup({required String email, required String password, required BuildContext context,}) async {setLoading(true);
    try {
      print("Inscription."+ "Utilisateur inscrit "+  FirebaseAuth.instance.currentUser!.email.toString());
      await authService.signup(email: email, password: password, context: context,);
    } on Exception catch (e) {
      print("Une erreur s'est produite: $e");
      print(e);    }
    setLoading(false);
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {setLoading(true);
    try {
      print("Connexion."+ "Utilisateur connecté "+  FirebaseAuth.instance.currentUser!.email.toString());
      await authService.signin(email: email, password: password, context: context,);
    } on Exception catch (e) {
      print("Une erreur s'est produite: $e");
      print(e);
    }
    setLoading(false);
  }

  Future<void> signout(BuildContext context) async {setLoading(true);
    try {
      print("Deconnexion."+ "Utilisateur déconnecté "+  FirebaseAuth.instance.currentUser!.email.toString());
      await authService.signout(context);
    } on Exception catch (e) {
      // TODO
    }
    setLoading(false);
  }

  Future<void> resetPassword({required String email, required BuildContext context,}) async {setLoading(true);

    try {
      print("Mot de passe rénitiliasé. Email envoyé à l'adresse" + email);
      await authService.resetPassword(email: email, context: context,);
    } on Exception catch (e) {
      print("Une erreur s'est produite: $e");
      print(e);
    }
    setLoading(false);
  }
}

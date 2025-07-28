import 'package:flutter/material.dart';
import '../web_services/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthService authService;

  User? get user => FirebaseAuth.instance.currentUser;

  AuthViewModel({required this.authService});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /***
   * Methode pour s'inscrire
   */
  Future<void> signup({required String email, required String password, required BuildContext context,}) async {setLoading(true);
    try {
      print("Inscription..."+ "Utilisateur inscrit "+  FirebaseAuth.instance.currentUser!.email.toString());
      await authService.signup(email: email, password: password, context: context,);
      emailController.clear();
      passwordController.clear();
    } on Exception catch (e) {
      // Gérer les erreurs d'inscription
      print("Une erreur s'est produite: $e");
      print(e);    }
    setLoading(false);
  }



  /***
   * Methode pour se connecter
   */
  Future<void> signin({required String email, required String password, required BuildContext context,}) async {setLoading(true);
    try {
      print("Connexion."+ "Utilisateur connecté ");
      await authService.signin(email: email, password: password, context: context,);
      emailController.clear();
      passwordController.clear();
    } on Exception catch (e) {
      print("Une erreur s'est produite: $e");
      print(e);
    }
    setLoading(false);
  }





  /***
   * Methode pour se deconnecter
   */
  Future<void> signout(BuildContext context) async {setLoading(true);
    try {
      print("Deconnexion."+ "Utilisateu  déconnecté");
      await authService.signout(context: context);
      emailController.clear();
      passwordController.clear();
    } on Exception catch (e) {
      print("Une erreur s'est produite: $e");
      print(e);
    }
    setLoading(false);
  }



  /***
   * Methode pour réinitialiser le mot de passe par email
   */
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

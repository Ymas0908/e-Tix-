import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/views_model/authentification_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../ressources/composants/LoadingDialog.dart';
import '../../web_services/services/auth_service.dart';
import '../home/home.dart';
import '../resetpassword/resetpassaword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: Alignment.center,
              child: Text(
                'Se connecter',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
            toolbarHeight: 50,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffD9AFA0), Color(0xFF052A6E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffD9AFA0), Color(0xFF052A6E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Form(
                  key: formKeyLogin,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'e-Tix',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Connectez-vous pour continuer",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),

                      // Email
                      Text(
                        'Adresse e-mail',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: authViewModel.emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Saisir votre adresse e-mail',
                          hintStyle: GoogleFonts.poppins(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Veuillez entrer une adresse e-mail';
                          }
                          if (!authViewModel.emailRegExp.hasMatch(email)) {
                            return 'Veuillez entrer une adresse e-mail valide';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Mot de passe
                      Text(
                        'Mot de passe',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: authViewModel.passwordController,
                        obscureText: _obscureText,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Saisir votre mot de passe',
                          hintStyle: GoogleFonts.poppins(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: _togglePasswordView,
                          ),
                        ),
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          if (password.length < 5) {
                            return 'Le mot de passe doit contenir au moins 5 caractères';
                          }
                          return null;
                        },

                      ),

                      // Mot de passe oublié
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            if (authViewModel.emailController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Veuillez entrer votre e-mail pour réinitialiser."),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ResetPassword()),);
                            authViewModel.resetPassword(email: authViewModel.emailController.text, context: context);
                            // AuthService().resetPassword(email: _emailController.text.trim(), context: context,);
                          },
                          child: Text(
                            'Mot de passe oublié ?',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Bouton connexion
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                          ),
                          onPressed: () async {
                            // Récupération des valeurs
                            final email = authViewModel.emailController.text.trim();
                            final password = authViewModel.passwordController.text.trim();

                            // Validation du formulaire
                            if (!formKeyLogin.currentState!.validate()) {
                              return;
                            }

                            // Affichage du loading dès le début de la tentative de connexion
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const LoadingDialog(
                                message: "Connexion en cours...",
                              ),
                            );

                            try {
                              // Tentative de connexion
                              await authViewModel.signin(
                                email: email,
                                password: password,
                                context: context,
                              );

                              // Fermer le loading si toujours monté
                              if (mounted) {
                                Navigator.of(context).pop(); // Fermer le loading

                                // Navigation vers l'écran Home
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => Home()),
                                );
                              }
                            } catch (e) {
                              // Gestion des erreurs
                              if (mounted) {
                                Navigator.of(context).pop(); // Fermer le loading
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Erreur de connexion: ${e.toString().replaceAll('Exception: ', '')}",
                                    ),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            "Se connecter",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: const Color(0xffD9AFA0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

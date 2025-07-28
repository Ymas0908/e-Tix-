import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../ressources/composants/LoadingDialog.dart';
import '../../views_model/authentification_viewmodel.dart';
import '../../web_services/services/auth_service.dart';
import '../home/home.dart';
import '../login/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText = true;
  final GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, authViewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'S\'inscrire',
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Form(
                key: formKeySignup,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    // Nom & prénom
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nom & Prénom',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: authViewModel.usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Entrez votre nom complet',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom complet';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Adresse e-mail',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: authViewModel.emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Saisir votre adresse e-mail',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer une adresse e-mail';
                            }
                            if (!authViewModel.emailRegExp.hasMatch(value)) {
                              return 'Veuillez entrer une adresse e-mail valide';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Mot de passe
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mot de passe',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: authViewModel.passwordController,
                          obscureText: _obscureText,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Saisir votre mot de passe',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: _togglePasswordView,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer un mot de passe';
                            }
                            if (value.length < 5) {
                              return 'Le mot de passe doit contenir au moins 5 caractères';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Bouton s'inscrire
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                      ),
                      onPressed: () async {
                        if (formKeySignup.currentState!.validate()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const LoadingDialog(
                                message: "Inscription en cours..."),
                          );

                          try {
                            // await AuthService().signup(email: authViewModel.emailController.text, password: authViewModel.passwordController.text, context: context,);
                            await authViewModel.signup(
                              email: authViewModel.emailController.text,
                              password: authViewModel.passwordController.text,
                              context: context,
                            );
                            Navigator.of(context).pop(); // close loading
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          } catch (e) {
                            Navigator.of(context).pop(); // close loading
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Une erreur est survenue lors de l'inscription."),
                                  backgroundColor: Colors.red),
                            );
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        "S'inscrire",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const Login()),
                        );
                      },
                      child: Text(
                        "Vous avez déjà un compte ? Se connecter",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

import 'package:auth_firebase/pages/login/login.dart';
import 'package:auth_firebase/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  // Controllers pour les champs de texte
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Expresion régulière pour valider l'adresse e-mail
  final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  // Clé du formulaire pour accéder à son état
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: _signin(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 50,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'S\'inscrire',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 32
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 80,),
                  _emailAddress(),
                  const SizedBox(height: 20,),
                  _password(),
                  const SizedBox(height: 50,),
                  _signup(context),
                ],
              ),
            ),
          ),
        )
    );
  }

  // Champ pour l'adresse e-mail
  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adresse e-mail',
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16
              )
          ),
        ),
        const SizedBox(height: 16,),
        TextFormField(
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16
              )
          ),
          controller: _emailController,
          decoration: InputDecoration(
              hintText: 'Saisir votre adresse e-mail',
              filled: true,
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14)
              )
          ),
          // Validation de l'email
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer une adresse e-mail';
            }
            if (!_emailRegExp.hasMatch(value)) {
              return 'Veuillez entrer une adresse e-mail valide';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Champ pour le mot de passe
  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mot de passe',
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16
              )
          ),
        ),
        const SizedBox(height: 16,),
        TextFormField(
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16
              )
          ),
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Saisir votre mot de passe',
              filled: true,
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14)
              )
          ),
          // Validation du mot de passe
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer un mot de passe';
            }
            if (value.length < 6) {
              return 'Le mot de passe doit contenir au moins 6 caractères';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Bouton d'inscription
  Widget _signup(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        // Valider le formulaire avant de procéder à l'inscription
        if (_formKey.currentState!.validate()) {
          // Si le formulaire est valide, procéder à l'inscription
          await AuthService().signup(
              email: _emailController.text,
              password: _passwordController.text,
              context: context
          );
        }
      },
      child: Text(
        "S'inscrire",
        style: GoogleFonts.raleway(
            textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16
            )
        ),
      ),
    );
  }

  // Lien pour se connecter si on a déjà un compte
  Widget _signin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Possédez-vous déjà un compte ? ",
              style: TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 16
              ),
            ),
            TextSpan(
                text: "Se connecter",
                style: const TextStyle(
                    color: Color(0xff1A1D1E),
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                ),
                recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login()
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}

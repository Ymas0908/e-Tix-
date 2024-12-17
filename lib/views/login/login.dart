import 'package:auth_firebase/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resetpassword/resetpassaword.dart';
import '../signup/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'e-Tix',
                  style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Connectez-vous pour continuer",
                style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16)),
              ),
              const SizedBox(
                height: 50,
              ),
              _emailAddress(),
              const SizedBox(
                height: 20,
              ),
              _password(),
              _forgortPassword(context),
              const SizedBox(
                height: 50,
              ),
              _signin(context),

            ],
          ),
        ),
      ),
    );
  }

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
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Saisir votre adresse e-mail',
            filled: true,
            fillColor: const Color(0xffF7F7F9),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14)),
          ),
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
                  fontSize: 16)),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16)),
          controller: _passwordController,
          obscureText: _obscureText, // Masquage du mot de passe
          decoration: InputDecoration(
            hintText: 'Saisir votre mot de passe',
            filled: true,
            fillColor: const Color(0xffF7F7F9),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14)),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: _togglePasswordView, // Basculer la visibilité
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
    );
  }

  Widget _forgortPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ResetPassword(),
            ),
          );
           AuthService().resetPassword
             (email: _emailController.text,
             context: context,
           );
        },
        child: Text(
          'Mot de passe oublié ?',
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Color(0xff0D6EFD),
                  fontWeight: FontWeight.normal,
                  fontSize: 14)),
        ),
      ),
    );
  }

  Widget _signin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // Process data
          AuthService().signin(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          );
        }
      },

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.login,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Se connecter",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
             TextSpan(
              text: "Nouvel utilisateur ? ",
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
            TextSpan(
              text: "Créer un compte",
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  color: Color(0xff0D6EFD),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

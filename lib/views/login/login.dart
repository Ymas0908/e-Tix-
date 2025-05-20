import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../web_services/services/auth_service.dart';
import '../resetpassword/resetpassaword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // pour afficher la flèche de retour
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F65D4), Color(0xFF052A6E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          // Fond dégradé
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F65D4), Color(0xFF052A6E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Bulles décoratives
          Positioned(top: 80, left: 30, child: _buildBubble(60)),
          Positioned(top: 200, right: 50, child: _buildBubble(40)),
          Positioned(bottom: 150, left: 60, child: _buildBubble(70)),
          Positioned(bottom: 300, right: 30, child: _buildBubble(90)),

          // Formulaire
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Form(
              key: _formKey,
              child: Column(
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
                  Text(
                    "Connectez-vous pour continuer",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 50),
                  _emailAddress(),
                  const SizedBox(height: 20),
                  _password(),
                  _forgotPassword(context),
                  const SizedBox(height: 40),
                  _signin(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adresse e-mail',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
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
          validator: (value) {
            if (value == null || value.isEmpty) return 'Veuillez entrer une adresse e-mail';
            if (!_emailRegExp.hasMatch(value)) return 'Veuillez entrer une adresse e-mail valide';
            return null;
          },
        ),

      ],
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mot de passe',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
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
        ),
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPassword()));
          AuthService().resetPassword(email: _emailController.text, context: context);
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
    );
  }

  Widget _signin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      ),
      onPressed: () {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();

        // Vérification si les champs sont vides
        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Veuillez remplir tous les champs."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Vérification si le mot de passe est trop court
        if (password.length < 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Le mot de passe doit contenir au moins 5 caractères."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Vérification via le formulaire (si d'autres champs existent)
        if (!(_formKey.currentState?.validate() ?? false)) {
          return;
        }

        // Si tout est valide, on lance la connexion
        AuthService().signin(email: email, password: password, context: context,);
      },

      child: Text(
        "Se connecter",
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBubble(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.3),
      ),
    );
  }
}

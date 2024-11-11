import 'package:auth_firebase/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rénitialisation de mot de passe', style: GoogleFonts.raleway()
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
      ),

      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Réinitialiser le mot de passe',
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
                  "Entrez votre adresse e-mail pour recevoir un lien de réinitialisation",
                  style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                _emailAddress(),
                const SizedBox(
                  height: 50,
                ),
                _sendResetLink(context),
              ],
            ),
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

  Widget _sendResetLink(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
      ),
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // Envoyer le lien de réinitialisation
          AuthService().resetPassword(
              email: _emailController.text,
            context: context,
          );
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text('Lien de réinitialisation envoyé',
                style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),

          ),
              backgroundColor: Color(0xff0D6EFD),
            ),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Envoyer ",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.send,
            color: Colors.white,
          ),

        ],
      ),
    );
  }
}

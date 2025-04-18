import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilsetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Paramètres du Profil",
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: const Color(0xff0D6EFD),
      ),
      body: Center(
        child: Text(
          "Paramètres du profil en cours de développement...",
          style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

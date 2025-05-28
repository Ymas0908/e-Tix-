import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InternetNotAvailableView extends StatefulWidget {
  const InternetNotAvailableView({super.key});

  @override
  State<InternetNotAvailableView> createState() =>
      _InternetNotAvailableViewState();
}

class _InternetNotAvailableViewState extends State<InternetNotAvailableView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 100, color: Colors.grey),
                const SizedBox(height: 24),
                Text(
                  "Connexion internet indisponible",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Veuillez vérifier votre connexion et réessayer.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9AFA0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // TODO: Ajouter logique de reconnexion ici
                    // Ex: vérifier si l'utilisateur est maintenant connecté à Internet
                  },
                  child: Text(
                    "Réessayer",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

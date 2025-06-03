import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../views/Test.dart';
import '../../views/mes_tickets_view.dart';
import '../../views/pageacceuil.dart';
import '../../views/profile/profil-setting.dart';
import '../../views_model/authentification_viewmodel.dart';
import 'LoadingDialog.dart';

class Appdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context,  authViewModel, child) {
        return Drawer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: DrawerHeader(
                    child: Text(
                      'Menu',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Bouton Voir les événements
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9AFA0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Test()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.event, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        "Voir les événements",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Bouton Effectuer Paiement
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9AFA0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Action à définir
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.payments, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        "Effectuer Paiement",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Bouton Paramètres
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9AFA0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilSettingView()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.settings, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        "Paramètres",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Bouton Paramètres
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9AFA0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MesTicketsView()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.confirmation_num, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        "Voir mes tickets",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                const SizedBox(height: 16),

                // Bouton Déconnexion
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD9AFA0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const LoadingDialog(
                        message: "Déconnexion en cours...",
                      ),
                    );
                    try {
                      await authViewModel.signout(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pageacceuil()),
                      );

                    }catch (e) {
                      Navigator.of(context).pop(); // close loading
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Erreur lors de la déconnexion : $e")),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: Colors.black),
                      const SizedBox(width: 10),
                      Text(
                        "Se déconnecter",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );

      });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilSettingView extends StatefulWidget {
  @override
  State<ProfilSettingView> createState() => _ProfilSettingViewState();
}

class _ProfilSettingViewState extends State<ProfilSettingView> {
  late FirebaseAuth firebaseAuth;


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: const Color(0xffD9AFA0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.grey[700],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: GoogleFonts.raleway(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock),
              title: Text("Changer le mot de passe",
                  style: GoogleFonts.raleway(fontSize: 16)),
              onTap: () {
                // Action de changement de mot de passe
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Redirection vers mot de passe...")),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

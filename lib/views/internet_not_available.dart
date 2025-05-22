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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.signal_wifi_off, size: 100),
                const SizedBox(width: 10),
                Text(
                  "Veuillez vérifier votre connexion internet.",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
          ],
        )),
      ),
    );
  }
}

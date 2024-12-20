import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/evenement_model.dart';
import '../../../ressources/format_date.dart';

class CardEvenement extends StatelessWidget {
  final EvenementModel evenementModel;

  const CardEvenement({super.key, required this.evenementModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            // Placeholder pour l'image. Remplacez avec Image.network ou autre source.
            child: Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey[300],
              child:  Image.network(
                evenementModel.urlImage ?? '',
                fit: BoxFit.cover,
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evenementModel.libelle ?? '',
                  maxLines: 2,
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                const SizedBox(height: 8),
                 Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.black, size: 18),
                    Text(
                      formatDate(evenementModel.dateEvenement),
                      style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                 Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.black, size: 18),
                    Text(
                      utf8.decoder.convert(evenementModel.lieu!.codeUnits),
                      style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0D6EFD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Action lors du clic sur le bouton
                    },
                    child: const Text(
                      'Voir détails',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detail_evenements.dart';

class EvenementsPopulairesView extends StatelessWidget {
  final List<Map<String, dynamic>> evenementsPopulaires = [
    {
      'title': 'Festival de Musique Electronique',
      'date': '25 Nov 2024',
      'location': 'Plage de Barcelone',
      'price': '120€',
      'image': 'assets/images/electro.jpg'
    },
    {
      'title': 'Exposition Art Contemporain',
      'date': '2 Dec 2024',
      'location': 'Musée d\'Art Moderne',
      'price': '15€',
      'image': 'assets/images/art_exhibit.jpg'
    },
    {
      'title': 'Stand-Up Comedy Show',
      'date': '5 Dec 2024',
      'location': 'Théâtre Municipal',
      'price': '30€',
      'image': 'assets/images/standup.jpg'
    },
    // Ajoutez plus d'événements ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Événements Populaires',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: const Color(0xff0D6EFD), // Couleur d'accent pour les événements populaires
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: evenementsPopulaires.length,
        itemBuilder: (context, index) {
          return _buildEventCard(context, evenementsPopulaires[index]);
        },
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                // child: Image.asset(
                //   event['image'],
                //   height: 200,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Populaire',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      event['date'],
                      style: GoogleFonts.raleway(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      event['location'],
                      style: GoogleFonts.raleway(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event['price'],
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff0D6EFD),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0D6EFD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => DetailEvenements(event: event)),
                        // );
                      },
                      child: const Text(
                        'Voir détails',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

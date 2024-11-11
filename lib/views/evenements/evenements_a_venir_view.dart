import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detail_evenements.dart';

class EvenementsAVenirView extends StatefulWidget {
  @override
  State<EvenementsAVenirView> createState() => _EvenementsAVenirViewState();
}

class _EvenementsAVenirViewState extends State<EvenementsAVenirView> {
  final List<String> categories = [
    'Tous',
    'Concerts',
    'Sport',
    'Théâtre',
    'Festivals',
    'Cinéma'
  ];

  int selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> upcomingEvents = [
    {
      'title': 'Concert Jazz Festival',
      'date': '15 Dec 2024',
      'location': 'Palais des Congrès',
      'price': '50€',
      'image': 'assets/images/jazz.jpg',
      'category': 'Concerts',
    },
    {
      'title': 'Match de Football',
      'date': '20 Dec 2024',
      'location': 'Stade Municipal',
      'price': '35€',
      'image': 'assets/images/football.jpg',
      'category': 'Sport',
    },
    {
      'title': 'Pièce de Théâtre',
      'date': '25 Dec 2024',
      'location': 'Théâtre Royal',
      'price': '40€',
      'image': 'assets/images/theatre.jpg',
      'category': 'Théâtre',
    },
    {
      'title': 'Festival de Musique',
      'date': '30 Dec 2024',
      'location': 'Parc des Expositions',
      'price': '60€',
      'image': 'assets/images/festival.jpg',
      'category': 'Festivals',
    },
    {
      'title': 'Film au Cinéma',
      'date': '5 Jan 2025',
      'location': 'Cinéplex',
      'price': '12€',
      'image': 'assets/images/cinema.jpg',
      'category': 'Cinéma',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Événements à venir',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Catégories',
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        categories[index],
                        style: GoogleFonts.raleway(),
                      ),
                      selected: selectedCategoryIndex == index,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      selectedColor: const Color(0xff0D6EFD),
                      labelStyle: TextStyle(
                        color: selectedCategoryIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Liste des événements à venir
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _filteredEvents().length,
              itemBuilder: (context, index) {
                return _buildEventCard(context, _filteredEvents()[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filteredEvents() {
    if (selectedCategoryIndex == 0) {
      return upcomingEvents; // Tous les événements
    } else {
      return upcomingEvents
          .where((event) => event['category'] == categories[selectedCategoryIndex])
          .toList(); // Filtre par catégorie
    }
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
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
            child: Image.asset(
              event['image'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailEvenements(event: event)),
                        );
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

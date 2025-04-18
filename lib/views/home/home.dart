import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/views/pageacceuil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Ajouté pour Firebase Auth

import '../../ressources/composants/Search_Input.dart';
import '../../ressources/constantes/appdefaults.dart';
import '../../services/auth_service.dart';
import '../../views_model/evenement_viewmodel.dart';
import '../evenements/composants/card_evenement.dart';
import '../evenements/evenements.dart';
import '../login/login.dart';
import '../messages/messages.dart';
import '../profile/profil-setting.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late EvenementViewModel evenementViewModel;
  int _currentIndex = 0; // 📌 Gestion de l'index pour afficher la bonne page

  @override
  void initState() {
    super.initState();
    evenementViewModel = context.read<EvenementViewModel>();
    evenementViewModel.getAllEvenements();
    evenementViewModel.nomEvenement.addListener(() {
      evenementViewModel.getLesEvenementsByNom(evenementViewModel.nomEvenement.text);
    });
  }

  // 📌 Liste des vues associées aux onglets du `BottomNavigationBar`
  final List<Widget> _pages = [
    HomeContent(), // 🏠 Page d'accueil avec événements
    Evenements(), // 🌍 Page d'exploration des événements
    Messages(), // 🗺️ Page des messages
    Profilsetting(), // 👤 Page des paramètres du profil
  ];

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'e-Tix',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: const Color(0xff0D6EFD),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: Colors.white,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),

      ),
      drawer: _buildDrawer(context),
      body: _pages[_currentIndex], // 📌 Affichage dynamique des pages
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Acceuil'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'), // 📌 Icône Profil
        ],
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xff0D6EFD),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 📌 Mise à jour de l'index lors du clic
          });
        },
      ),
    );
  }

  // Méthode de déconnexion

  Widget _buildDrawer(BuildContext context) {
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
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            // Ajoutez d'autres éléments de menu ici, s'ils existent
            const Spacer(), // Ajoute un espacement flexible qui pousse le bouton vers le bas
            _logout(context), // Déconnexion en bas du Drawer
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
Widget _logout(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff0D6EFD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      minimumSize: const Size(double.infinity, 60),
      elevation: 0,
    ),
    onPressed: () async {
      await AuthService().signout(context: context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Pageacceuil()),
      );
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.logout, color: Colors.white),
        const SizedBox(width: 10),
        Text(
          "Se déconnecter",
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}


// 🏠 **Page d'accueil avec la liste des événements**
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final evenementViewModel = context.watch<EvenementViewModel>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      child: Column(
        children: [
          const SizedBox(height: 10),
          SearchInput(
            controller: evenementViewModel.nomEvenement,
            placeholder: 'Rechercher un événement',
            icon: const Icon(Icons.search),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${evenementViewModel.evenements.length} événements trouvés',
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: evenementViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : evenementViewModel.evenements.isEmpty
                ? Center(
              child: Text(
                'Aucun événement disponible.',
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
                : ListView.builder(
              itemCount: evenementViewModel.evenements.length,
              itemBuilder: (context, index) {
                return CardEvenement(
                  evenementModel: evenementViewModel.evenements[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class EventCard extends StatelessWidget {
//   final Map<String, dynamic> event;
//
//   const EventCard({Key? key, required this.event}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: () {
//           // Navigation vers les détails de l'événement
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             children: [
//               // Image de l'événement
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   event['image'],
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               // Informations de l'événement
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       event['title'],
//                       style: GoogleFonts.raleway(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           event['date'],
//                           style: GoogleFonts.raleway(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           event['location'],
//                           style: GoogleFonts.raleway(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Prix
//               Text(
//                 event['price'],
//                 style: GoogleFonts.raleway(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xff0D6EFD),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PopularEventCard extends StatelessWidget {
//   final Map<String, dynamic> event;
//
//   const PopularEventCard({Key? key, required this.event}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       margin: const EdgeInsets.only(right: 16),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: InkWell(
//           onTap: () {
//             // Navigation vers les détails de l'événement
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.asset(
//                   event['image'],
//                   height: 120,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       event['title'],
//                       style: GoogleFonts.raleway(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       event['location'],
//                       style: GoogleFonts.raleway(
//                         color: Colors.grey[600],
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
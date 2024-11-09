import 'package:auth_firebase/views/evenements/evenements_a_venir_view.dart';
import 'package:auth_firebase/views/evenements/evenements_populaires_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_firebase/services/auth_service.dart';
import '../login/login.dart';
import '../messages/messages.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final List<Map<String, dynamic>> upcomingEvents = [
  //   {
  //     'title': 'Concert Jazz Festival',
  //     'date': '15 Dec 2024',
  //     'location': 'Palais des Congrès',
  //     'price': '50€',
  //     'image': 'assets/images/jazz.jpg'
  //   },
  //   {
  //     'title': 'Match de Football',
  //     'date': '20 Dec 2024',
  //     'location': 'Stade Municipal',
  //     'price': '35€',
  //     'image': 'assets/images/football.jpg'
  //   },
  //   // Ajoutez plus d'événements ici
  // ];

  final List<String> categories = [
    'Tous',
    'Concerts',
    'Sport',
    'Théâtre',
    'Festivals',
    'Cinéma'
  ];

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('e-Tix',
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
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
        actions: [
          IconButton(
            color: Colors.white,

            icon: const Icon(Icons.search),
            onPressed: () {
              // Implémenter la recherche
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Implémenter les notifications
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message de bienvenue
                Row(
                  children: [
                    Text(
                      'Bienvenue, ',
                      style: GoogleFonts.raleway(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.waving_hand, color: Colors.amber),
                  ],
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email!.toString(),
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Catégories
                Text(
                  'Catégories',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
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

                const SizedBox(height: 24),

                // Événements à venir
                Text(
                  'Événements à venir',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: upcomingEvents.length,
                //   itemBuilder: (context, index) {
                //     return EvenementsAVenirView(event: upcomingEvents[index]);
                //   },
                // ),


                const SizedBox(height: 24),

                // Événements populaires
                Text(
                  'Événements populaires',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  // child: ListView.builder(
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: upcomingEvents.length,
                  //   itemBuilder: (context, index) {
                  //     return PopularEventCard(event: upcomingEvents[index]);
                  //   },
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
            const SizedBox(height: 50),
            ListTile(
              leading: const Icon(Icons.message, color: Color(0xff0D6EFD)),
              title: Text(
                'Messages',
                style: GoogleFonts.raleway(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Messages()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.event, color: Color(0xff0D6EFD)),
              title: Text(
                'Evénements à venir',
                style: GoogleFonts.raleway(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EvenementsAVenirView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.event, color: Color(0xff0D6EFD)),
              title: Text(
                'Evénements populaires',
                style: GoogleFonts.raleway(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EvenementsPopulairesView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xff0D6EFD)),
              title: Text(
                'Paramètres',
                style: GoogleFonts.raleway(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Spacer(),
            _logout(context),
          ],
        ),
      ),
    );
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
          MaterialPageRoute(builder: (context) => Login()),
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
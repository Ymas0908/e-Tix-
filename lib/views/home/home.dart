import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/views/evenements/detail_evenements.dart';
import 'package:my_app/views/pageacceuil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../ressources/composants/Search_Input.dart';
import '../../ressources/constantes/appdefaults.dart';
import '../../web_services/services/auth_service.dart';
import '../../views_model/evenement_viewmodel.dart';
import '../evenements/composants/card_evenement.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late EvenementViewModel evenementViewModel;

  @override
  void initState() {
    super.initState();
    evenementViewModel = context.read<EvenementViewModel>();
    evenementViewModel.getAllEvenements();
    evenementViewModel.getEvenementBylibelle(context);
  }

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
      body: RefreshIndicator(
          onRefresh: () async {
            await evenementViewModel.getAllEvenements();
          },          child: HomeContent(),
      backgroundColor: Colors.grey.shade200), // Affichage de la page d'accueil seulement
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
            const Spacer(),
            _logout(context),
            const SizedBox(height: 16),
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
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final evenementViewModel = context.watch<EvenementViewModel>();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextField(
                  onChanged: evenementViewModel.filterEvenements,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.black),
                  enableInteractiveSelection: true,
                  showCursor: true,
                  controller: evenementViewModel.searchEventController,
                  decoration: InputDecoration(
                    suffixIcon: evenementViewModel
                        .searchEventController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => evenementViewModel
                          .searchEventController
                          .clear(),
                    )
                        : null,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Rechercher un événement',
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${evenementViewModel.evenements.length} événements trouvés',
                    style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid.builder(
            itemCount: evenementViewModel.listeStubs.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final event = evenementViewModel.listeStubs[index];
              return GestureDetector(
                onTap: () {
                  if (!evenementViewModel.isEventLoading) {
                    evenementViewModel.setSelectedEvenement(event);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailEvenements(),
                      ),
                    );
                  }
                },
                child: Skeleton(
                  isLoading: evenementViewModel.isEventLoading,
                  skeleton: const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      padding: EdgeInsets.all(10),
                      width: 200,
                      height: 200,
                    ),
                  ),
                  child: CardEvenement(
                    evenementModel: event,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

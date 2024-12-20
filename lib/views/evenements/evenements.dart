import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../ressources/composants/Search_Input.dart';
import '../../ressources/constantes/appdefaults.dart';
import '../../views_model/evenement_viewmodel.dart';
import 'composants/card_evenement.dart';

class Evenements extends StatefulWidget {
  const Evenements({super.key});

  @override
  State<Evenements> createState() => _EvenementsState();
}

class _EvenementsState extends State<Evenements> {
  @override
  void initState() {
    super.initState();
    context
        .read<EvenementViewModel>()
        .getEvenements(1); // Récupérer les données des appels de fond
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SearchInput(
                controller: TextEditingController(),
                placeholder: 'Rechercher un événement',
                icon: const Icon(Icons.search),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Liste des événements',
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Consumer<EvenementViewModel>(
                  builder: (context, evenementViewModel, _) {
                    if (evenementViewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (evenementViewModel.evenements.isEmpty) {
                      return Center(
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
                      );
                    }

                    return ListView.builder(
                      itemCount: evenementViewModel.evenements.length,
                      itemBuilder: (context, index) {
                        return CardEvenement(
                          evenementModel: evenementViewModel.evenements[index],
                        );
                      },
                    );
                    // return GridView.builder(
                    //   padding: const EdgeInsets.all(8.0),
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2, // Nombre de colonnes dynamique
                    //     crossAxisSpacing: 10.0, // Espacement horizontal
                    //     mainAxisSpacing: 10.0, // Espacement vertical
                    //     childAspectRatio: 0.8, // Ratio largeur/hauteur
                    //   ),
                    //   itemCount: evenementViewModel.evenements.length,
                    //   itemBuilder: (context, index) {
                    //     return CardEvenement(
                    //       evenementModel: evenementViewModel.evenements[index],
                    //     );
                    //   },
                    // );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

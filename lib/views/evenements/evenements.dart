import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../ressources/composants/Search_Input.dart';
import '../../ressources/composants/responsive_grid.dart';
import '../../ressources/constantes/appdefaults.dart';
import '../../views_model/evenement_viewmodel.dart';
import 'composants/card_evenement.dart';

class Evenements extends StatefulWidget {
  const Evenements({super.key});

  @override
  State<Evenements> createState() => _EvenementsState();
}

class _EvenementsState extends State<Evenements> {
  late EvenementViewModel evenementViewModel;

  @override
  void initState() {
    super.initState();
    evenementViewModel = context.read<EvenementViewModel>();
    evenementViewModel.getEvenements(1);
    evenementViewModel.libelleEvenement.addListener(() {
      evenementViewModel.getEvenementBylibelle(
        evenementViewModel.libelleEvenement.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Événements',
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
        body: Consumer<EvenementViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SearchInput(
                    controller: viewModel.libelleEvenement,
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
                        style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                   SizedBox(height: 10),
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

                        // Alternative: affichage en grille (décommenter si besoin)
                        // return ResponsiveGrid(
                        //   children: evenementViewModel.evenements.map((evenement) {
                        //     return CardEvenement(evenementModel: evenement);
                        //   }).toList(),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

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
  late EvenementViewModel evenementViewModel;

  @override
  void initState() {
    super.initState();
    evenementViewModel = context.read<EvenementViewModel>();
    evenementViewModel.getAllEvenements();

    // Mise à jour des événements lorsque le texte change dans la barre de recherche
    evenementViewModel.nomEvenement.addListener(() {
      evenementViewModel.getLesEvenementsByNom(evenementViewModel.nomEvenement.text);
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
          builder: (context, evenementViewModel, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Bar de recherche
                  SearchInput(
                    controller: evenementViewModel.nomEvenement,
                    placeholder: 'Rechercher un événement',
                    icon: const Icon(Icons.search),
                  ),
                  const SizedBox(height: 10),
                  // Affichage du nombre d'événements trouvés
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${evenementViewModel.evenements.length} évènements trouvés',
                        style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Affichage de la liste des événements
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
          },
        ),
      ),
    );
  }
}

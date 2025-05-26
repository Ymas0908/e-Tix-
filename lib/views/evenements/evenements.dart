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
    WidgetsBinding.instance.addPostFrameCallback((_) {


      if (evenementViewModel.evenements.isEmpty) {
        evenementViewModel.getLesEvenementsByNom(context);
      }

      if (evenementViewModel.evenements.isEmpty) {
        evenementViewModel.getEvenementBylibelle(context);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<EvenementViewModel>(
          builder: (context, evenementViewModel, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Bar de recherche
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
                        onPressed: () =>
                            evenementViewModel.searchEventController.clear(),
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
                    child: evenementViewModel.isEventLoading
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

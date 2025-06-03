import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../ressources/composants/AppDrawer.dart';
import '../../ressources/composants/Search_Input.dart';
import '../../ressources/constantes/appdefaults.dart';
import '../../utils/network_status_listener.dart';
import '../../views_model/authentification_viewmodel.dart';
import '../../web_services/services/auth_service.dart';
import '../../views_model/evenement_viewmodel.dart';
import '../../web_services/services/notchPay_service.dart';
import '../Test.dart';
import '../evenements/composants/card_evenement.dart';
import '../evenements/detail_evenements.dart';
import '../profile/profil-setting.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late EvenementViewModel evenementViewModel;
  late NotchpayService notchpayService;
  late AuthViewModel authViewModel;

  @override
  void initState() {
    super.initState();
    evenementViewModel = context.read<EvenementViewModel>();
    evenementViewModel.getAllEvenements(context);
    evenementViewModel.getEvenementBylibelle(context);
  }

  @override
  Widget build(BuildContext context) {
    return NetworkStatusListener(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Accueil',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          backgroundColor: const Color(0xffD9AFA0),
        ),
        drawer: Appdrawer(),
        body: RefreshIndicator(
          color: Color(0xffD9AFA0),
          onRefresh: () async {
            await evenementViewModel.getAllEvenements(context);
          },
          child: Container(
            color: Colors.grey.shade100, // 🔹 Couleur de fond ici
            child: NetworkStatusListener(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          TextField(
                            onChanged: evenementViewModel.filterEvenements,
                            keyboardType: TextInputType.text,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
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
                          const SizedBox(height: 30),
                          // SizedBox(
                          //   height: 40,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: evenementViewModel.listTypeEvenement.length,
                          //     itemBuilder: (context, index) {
                          //       final type = evenementViewModel.listTypeEvenement[index];
                          //       final isSelected = evenementViewModel.selectedTypeEvenement == type;
                          //
                          //       return Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 8),
                          //         child: ChoiceChip(
                          //           backgroundColor: Colors.white,
                          //           label: Text(
                          //             type.name.replaceAll('_', ' ').toString(),
                          //             style: GoogleFonts.poppins(
                          //               color: isSelected ? Colors.white : Colors.black,
                          //             ),
                          //           ),
                          //           selected: isSelected,
                          //           selectedColor: const Color(0xffD9AFA0),
                          //           onSelected: (_) {
                          //             evenementViewModel.setSelectedTypeEvenement(type);
                          //           },
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),


                        ],
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: evenementViewModel.evenements.isEmpty
                        ?  SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Text(
                            'Aucun événement disponible.',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                        : SliverGrid.builder(
                      itemCount: evenementViewModel.evenements.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                      ),
                      itemBuilder: (context, index) {
                        final event = evenementViewModel.evenements[index];
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}



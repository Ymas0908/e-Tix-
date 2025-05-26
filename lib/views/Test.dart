

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/views/evenements/composants/card_evenement.dart';
import 'package:my_app/views/evenements/detail_evenements.dart';
import 'package:my_app/views_model/evenement_viewmodel.dart';
import 'package:provider/provider.dart';

import '../utils/network_status_listener.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late EvenementViewModel evnementViewModel;


  @override
  void initState() {
    super.initState();
    final evnementViewModel = Provider.of<EvenementViewModel>(context, listen: false);
    evnementViewModel.getAllEvenements(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: const Text("Tous les évènements",)),
      body: Consumer<EvenementViewModel>(
        builder:
            (context, evnementViewModel, _) {
          if (evnementViewModel.isEventLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              // await evnementViewModel.refreshMmps(context);
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Champ de recherche
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Skeleton(
                        isLoading: evnementViewModel.isEventLoading &&
                            evnementViewModel.isEventLoading,
                        skeleton: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                        child: TextField(
                          onChanged: evnementViewModel.filterEvenements,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.black),
                          enableInteractiveSelection: true,
                          showCursor: true,
                          controller: evnementViewModel.searchEventController,
                          decoration: InputDecoration(
                            suffixIcon: evnementViewModel
                                .searchEventController.text.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () =>
                                  evnementViewModel.searchEventController.clear(),
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
                      )),
                ),



                // SliverToBoxAdapter(
                //   child:,
                // ),
                // Message si aucn événement trouvé
                evnementViewModel.evenements.isEmpty &&
                    !evnementViewModel.isEventLoading
                    ? SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          // Image.asset(
                          //   'assets/icons/marchand.png',
                          //   height: 85,
                          //   width: 85,
                          // ),
                          const SizedBox(height: 25),
                          Text(
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            "Aucun évenement disponible pour le moment.",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              fontFamily:
                              GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    :
                // Liste des mini-marketplaces sous forme de grille
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverGrid.builder(
                    itemCount: evnementViewModel.evenements.length,
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                    ),
                    itemBuilder: (context, index) {
                      final event = evnementViewModel.evenements[index];
                      return GestureDetector(
                        onTap: () {
                          if (!evnementViewModel.isEventLoading) {
                            evnementViewModel.setSelectedEvenement(event);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const DetailEvenements(),
                                ));
                          }
                        },
                        child: Skeleton(
                          isLoading: evnementViewModel.isEventLoading,
                          skeleton: const SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              padding: EdgeInsets.all(10),
                              width: 200,
                              height: 200,
                            ),
                          ),
                          child: CardEvenement(
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/network_status_listener.dart';
import '../views_model/evenement_viewmodel.dart';
import 'evenements/composants/card_evenement.dart';
import 'evenements/detail_evenements.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late EvenementViewModel evenementViewModel;


  @override
  void initState() {
    super.initState();
    evenementViewModel = Provider.of<EvenementViewModel>(context, listen: false);
    evenementViewModel.getAllEvenements(context);
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
            (context, evenementViewModel, _) {
          if (evenementViewModel.isEventLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              // await evenementViewModel.refreshMmps(context);
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
                        isLoading: evenementViewModel.isEventLoading &&
                            evenementViewModel.isEventLoading,
                        skeleton: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: double.infinity,
                            height: 50,
                          ),
                        ),
                        child: TextField(
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
                      )),
                ),



                // SliverToBoxAdapter(
                //   child:,
                // ),
                // Message si aucn événement trouvé
                evenementViewModel.evenements.isEmpty &&
                    !evenementViewModel.isEventLoading
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
                // Liste des evenements sous forme de grille
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverGrid.builder(
                    itemCount: evenementViewModel.evenements.length,
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                  builder: (context) =>
                                  const DetailEvenements(),
                                ));
                          }
                        },
                        child: Skeleton(
                          isLoading: evenementViewModel!.isEventLoading,
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
            ),
          );
        },
      ),
    );
  }

}

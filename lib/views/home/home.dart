import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../ressources/composants/AppDrawer.dart';
import '../../ressources/constantes/appdefaults.dart';
import '../../utils/network_status_listener.dart';
import '../../views_model/evenement_viewmodel.dart';
import '../evenements/composants/card_evenement.dart';
import '../evenements/detail_evenements.dart';

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
          color: const Color(0xffD9AFA0),
          onRefresh: () async {
            await evenementViewModel.getAllEvenements(context);
          },
          child: Container(
            color: Colors.grey.shade100,
            child: Consumer<EvenementViewModel>(
              builder: (context, viewModel, _) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            TextField(
                              onChanged: viewModel.filterEvenements,
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
                              controller: viewModel.searchEventController,
                              decoration: InputDecoration(
                                suffixIcon: viewModel.searchEventController.text.isNotEmpty
                                    ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => viewModel.searchEventController.clear(),
                                )
                                    : null,
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Rechercher un événement',
                              ),
                            ),
                            const SizedBox(height: 30),
                            // filtre par type éventuel ici
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8),
                      sliver: viewModel.isEventLoading
                          ? SliverGrid.builder(
                        itemCount: 6, // nombre arbitraire de skeletons
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return const SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              padding: EdgeInsets.all(10),
                              width: 200,
                              height: 200,
                            ),
                          );
                        },
                      )
                          : (viewModel.evenements.isEmpty
                          ? SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 60),
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
                        itemCount: viewModel.evenements.length,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final event = viewModel.evenements[index];
                          return GestureDetector(
                            onTap: () {
                              if (!viewModel.isEventLoading) {
                                viewModel.setSelectedEvenement(event);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DetailEvenements(),
                                  ),
                                );
                              }
                            },
                            child: Skeleton(
                              isLoading: viewModel.isEventLoading,
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
                      )),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

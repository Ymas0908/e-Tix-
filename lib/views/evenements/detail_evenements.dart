import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/models/enum/type_evenement.dart';
import 'package:my_app/views_model/evenement_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../ressources/constantes/format_date.dart';

class DetailEvenements extends StatefulWidget {
  const DetailEvenements({super.key});

  @override
  State<DetailEvenements> createState() => _DetailEvenementsState();
}

class _DetailEvenementsState extends State<DetailEvenements> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EvenementViewModel>(
      builder: (context, viewModel, child) {
        final evenement = viewModel.selectedEvenement;
        final type = viewModel.selectedTypeEvenement;

        if (evenement == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              evenement.nom.toString(),
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

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image + bouton lecture
                Stack(
                  children: [
                    Image.network(
                      evenement.urlImage.toString(),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Date + Genre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                            formatDate(evenement.dateEvenement),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Genre", style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xffD9AFA0),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  getTypeEvenement(evenement.typeEvenement) ?? "",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 6),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Lieu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lieu", style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        evenement.lieu,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                ),
                SizedBox(height: 20),

                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),

                // Synopsis
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description", style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        evenement.description ??
                            "Pas de description disponible.",
                        style: GoogleFonts.poppins(height: 1.5),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Bouton réserver
                Center(
                  child: ElevatedButton(
                   onPressed: (){

                   },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD9AFA0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Réserver un ticket",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }


  // void _showCinePayBottomSheet(BuildContext context) {
  //   final montantController = TextEditingController();
  //   final refController = TextEditingController();
  //   final evenementViewModel = Provider.of<EvenementViewModel>(
  //       context, listen: false);
  //
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           left: 16,
  //           right: 16,
  //           bottom: MediaQuery
  //               .of(context)
  //               .viewInsets
  //               .bottom + 16,
  //           top: 16,
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               height: 5,
  //               width: 50,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[300],
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //             Text("Paiement CinePay", style: GoogleFonts.poppins(
  //                 fontSize: 20, fontWeight: FontWeight.bold)),
  //             const SizedBox(height: 20),
  //             TextField(
  //               controller: montantController,
  //               decoration: const InputDecoration(
  //                 labelText: 'Montant',
  //                 border: OutlineInputBorder(),
  //               ),
  //               keyboardType: TextInputType.number,
  //             ),
  //             const SizedBox(height: 10),
  //             TextField(
  //               controller: refController,
  //               decoration: const InputDecoration(
  //                 labelText: 'Référence de la commande',
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color(0xffD4D8B0),
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 24, vertical: 12),
  //               ),
  //               child: Text(
  //                   "Payer", style: GoogleFonts.poppins(color: Colors.white)),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  String? getTypeEvenement(TypeEvenement typeEvenement) {
    switch (typeEvenement) {
      case TypeEvenement.MATCH:
        return "Match";
      case TypeEvenement.RELEASE_PARTY:
        return "Release Party";
      case TypeEvenement.THEATRE:
        return "Theatre";
      case TypeEvenement.CINEMA:
        return "Cinema";
      case TypeEvenement.CONCERT:
        return "Concert";
      case TypeEvenement.FESTIVAL:
        return "Festival";
      case TypeEvenement.EXPOSITION:
        return "Exposition";
      default:
        return null;
    }
  }


}

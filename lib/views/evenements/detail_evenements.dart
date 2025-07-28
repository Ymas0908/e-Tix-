import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/enum/type_evenement.dart';
import '../../ressources/composants/showDetailTicket.dart';
import '../../ressources/constantes/format_date.dart';
import '../../views_model/evenement_viewmodel.dart';

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

        if (evenement == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              evenement.nom ??'',
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
                Stack(
                  children: [
                    // Image.network(
                    //   evenement.urlImage.toString(),
                    //   width: double.infinity,
                    //   height: 300,
                    //   fit: BoxFit.cover,
                    // ),
                    Image.network(
                        evenement.urlImage.toString(),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      Center(child: const Icon(Icons.image_not_supported, size: 300)),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Date & Genre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                            formatDate(evenement.dateHeureEvenement),
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Genre", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xffD9AFA0),
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
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Lieu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lieu", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        evenement.lieu,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Divider(thickness: 1, color: Colors.grey.shade300),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        evenement.description ?? "",
                        maxLines: 10,
                        style: GoogleFonts.poppins(height: 1.5),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Bouton Réserver
                Center(
                  child: ElevatedButton(
                    onPressed: () => _showTicketBottomSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD9AFA0),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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

  void _showTicketBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) =>  const ShowDetailTicket(),
    );
  }

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

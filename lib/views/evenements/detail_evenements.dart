import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/models/evenement_model.dart';
import 'package:my_app/views_model/evenement_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../ressources/constantes/formarCurrency.dart';
import '../../ressources/constantes/format_date.dart';

class DetailEvenements extends StatefulWidget {


  @override
  State<DetailEvenements> createState() => _DetailEvenementsState();
}

class _DetailEvenementsState extends State<DetailEvenements> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<EvenementViewModel>(
      builder: (context, evenementViewModel, child) {
         return Scaffold(
           appBar: AppBar(
             title: Text(
               '${evenementViewModel.selectedEvenement?.libelle}',
               style: GoogleFonts.raleway(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
               ),
             ),
             backgroundColor: const Color(0xff0D6EFD),
           ),
           body: SingleChildScrollView(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 // Stack(
                 //   children: [
                 //     Image.network(
                 //       evenementModel.urlImage,
                 //       height: 250,
                 //       width: double.infinity,
                 //       fit: BoxFit.cover,
                 //     ),
                 //     Positioned(
                 //       bottom: 16,
                 //       right: 16,
                 //       child: Container(
                 //         padding: const EdgeInsets.all(8.0),
                 //         decoration: BoxDecoration(
                 //           color: Colors.black54,
                 //           borderRadius: BorderRadius.circular(8),
                 //         ),
                 //         child: Text(
                 //           formatDate(evenementModel.dateEvenement),
                 //           style: GoogleFonts.raleway(
                 //             color: Colors.white,
                 //             fontWeight: FontWeight.bold,
                 //           ),
                 //         ),
                 //       ),
                 //     ),
                 //   ],
                 // ),
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                           evenementViewModel.selectedEvenement?.nom ?? '',
                         style: GoogleFonts.raleway(
                           fontSize: 24,
                           fontWeight: FontWeight.bold,
                           color: Colors.black87,
                         ),
                       ),
                       const SizedBox(height: 8),
                       Row(
                         children: [
                           const Icon(Icons.location_on, color: Colors.grey),
                           const SizedBox(width: 8),
                           // Decode using utf8.decode() instead of converting
                           Text(
                             utf8.decode(evenementViewModel.selectedEvenement!.lieu.codeUnits, allowMalformed: true),
                             style: GoogleFonts.raleway(
                               fontSize: 16,
                               color: Colors.grey[600],
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 8),
                       Row(
                         children: [
                           const Icon(Icons.padding, color: Colors.grey),
                           const SizedBox(width: 8),
                           // Decode using utf8.decode() instead of converting
                           Text(
                             evenementViewModel.selectedEvenement!.prixTicketVVIP.toString(),
                             style: GoogleFonts.raleway(
                               fontSize: 16,
                               color: Colors.grey[600],
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 8),
                       Row(
                         children: [
                           const Icon(Icons.calendar_today, color: Colors.grey),
                           const SizedBox(width: 8),
                           // Decode using utf8.decode() instead of converting
                           Text(
                             formatDate(evenementViewModel.selectedEvenement?.dateEvenement),
                             style: GoogleFonts.raleway(
                               fontSize: 16,
                               color: Colors.grey[600],
                             ),
                           ),
                         ],
                       ),

                       const SizedBox(height: 24),
                       Center(
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             padding: const EdgeInsets.symmetric(
                               vertical: 12.0,
                               horizontal: 24.0,
                             ),
                             backgroundColor: const Color(0xff0D6EFD),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8),
                             ),
                           ),
                           onPressed: () {

                             },

                           child: Text(
                             'Réserver une place',
                             style: GoogleFonts.raleway(
                               fontSize: 16,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
         );
      },
    );
  }

  void _showCinePayBottomSheet(BuildContext context) {
    final montantController = TextEditingController();
    final refController = TextEditingController();
    final evenementViewModel = Provider.of<EvenementViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Paiement CinePay',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: montantController,
                decoration: const InputDecoration(
                  labelText: 'Montant',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: refController,
                decoration: const InputDecoration(
                  labelText: 'Référence de la commande',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    backgroundColor: const Color(0xff0D6EFD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final montant = int.tryParse(montantController.text.trim()) ?? 0;
                      final refCommande = refController.text.trim();

                      // await evenementViewModel.ini();
                      Navigator.of(context).pop(); // Fermer le bottom sheet si tout est ok
                    } catch (e) {
                      if (kDebugMode) print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erreur: ${e.toString()}")),
                      );
                    }
                  },
                  child: Text(
                    'Payer',
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

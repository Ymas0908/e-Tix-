import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/models/enum/type_ticket.dart';
import 'package:my_app/views_model/evenement_viewmodel.dart';
import 'package:provider/provider.dart';

class ShowDetailTicket extends StatefulWidget {
  const ShowDetailTicket({super.key});

  @override
  State<ShowDetailTicket> createState() => _ShowDetailTicketState();
}

class _ShowDetailTicketState extends State<ShowDetailTicket> {
  int ticketQuantity = 1;


  // void _reserveTicket() {
  //   Navigator.pop(context); // Ferme le BottomSheet par exemple
  //   // Ajoute ici l'action de réservation réelle (API, local, etc.)
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: Text("Réservation confirmée"),
  //       content: Text(
  //           "Vous avez réservé $ticketQuantity ticket(s) de type ${viewModel.selectedTypeTicket.toString()}."),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: Text("OK"),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<EvenementViewModel>(builder: (context, viewModel, child) {
       return Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             ListTile(
               title: Text('Confirmation de réservation',style: GoogleFonts.poppins(
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
               ),
               ),
             ),
             const SizedBox(height: 16),

             // Sélection du type de ticket
             DropdownButtonFormField<TypeTicket>(
               value: viewModel.selectedTypeTicket,
               items: viewModel.listTypeTicket.map(
                     (typeTicket) => DropdownMenuItem(
                   value: typeTicket,
                   child: Text(typeTicket.name,style: GoogleFonts.poppins(),),
                 ),
               ).toList(),
               onChanged: (value) {
                 viewModel.selectedTypeTicket = value;
               },
               decoration: InputDecoration(
                 labelText: "Sélectionner un type de ticket",
                 labelStyle: GoogleFonts.poppins(),
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
               ),
             ),
             const SizedBox(height: 16),
             // TextField(
             //   controller: viewModel.selectedTicket!.prix,
             //   keyboardType: TextInputType.number,
             //   decoration: InputDecoration(
             //     contentPadding: const EdgeInsets.symmetric(
             //         vertical: 16, horizontal: 16),
             //     labelText: "Prix du ticket",
             //     labelStyle: GoogleFonts.poppins(),
             //     border: OutlineInputBorder(
             //       borderRadius: BorderRadius.circular(15),
             //     ),
             //   ),
             // ),


             // Sélection du nombre de tickets
             Row(
               children: [
                 Text("Quantité :",
                   style: GoogleFonts.poppins(),),
                 const SizedBox(width: 10),
                 IconButton(
                   onPressed: () {
                     if (ticketQuantity > 1) {
                       setState(() => ticketQuantity--);
                     }
                   },
                   icon: Icon(Icons.remove),
                 ),
                 Text(ticketQuantity.toString(),
                   style: GoogleFonts.poppins(),),
                 IconButton(
                   onPressed: () {
                     setState(() => ticketQuantity++);
                   },
                   icon: Icon(Icons.add),
                 ),
               ],
             ),
             const SizedBox(height: 20),

             // Bouton réserver
             Center(
               child: ElevatedButton(
                 onPressed: () {},
                 style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xffD9AFA0),
                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                       "Réserver un ticket",
                       style: GoogleFonts.poppins(
                           color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(width: 8),

                     Icon(Icons.confirmation_num, color: Colors.black),

                   ],
                 ),
               ),
             ),
           ],
         ),
       );
    });
  }
}

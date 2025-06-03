// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
//
// class MesTicketsView extends StatefulWidget {
//   @override
//   State<MesTicketsView> createState() => _MesTicketsViewState();
// }
//
// class _MesTicketsViewState extends State<MesTicketsView> {
//
//
//   // 🔁 Exemple de récupération simulée
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Mes tickets',
//           style: GoogleFonts.poppins(
//             textStyle: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         backgroundColor: const Color(0xffD9AFA0),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Liste de mes tickets reservés",
//                 style: GoogleFonts.raleway(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const Divider(),
//             Expanded(
//               child: tickets.isEmpty
//                   ? const Center(child: CircularProgressIndicator())
//                   : ListView.builder(
//                 itemCount: tickets.length,
//                 itemBuilder: (context, index) {
//                   final ticket = tickets[index];
//                   return Card(
//                     elevation: 2,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       leading: const Icon(Icons.confirmation_number),
//                       title: Text(ticket.titre),
//                       subtitle: Text("${ticket.date} • ${ticket.lieu}"),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

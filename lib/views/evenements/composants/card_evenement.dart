import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/models/evenement_model.dart';
import 'package:my_app/views/evenements/evenements.dart';
import 'package:my_app/views_model/evenement_viewmodel.dart';
import 'package:provider/provider.dart';

class CardEvenement extends StatefulWidget {
  const CardEvenement({
    super.key,
    required this.evenementModel
  });
  final EvenementModel evenementModel;


  @override
  State<CardEvenement> createState() => _CardEvenementState();
}

class _CardEvenementState extends State<CardEvenement> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EvenementViewModel>(
      builder: (context, evenementViewModel, _) {

        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, // Largeur adaptée
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.evenementModel.urlImage ?? '',
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Titre
                  Text(
                    widget.evenementModel.nom ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.evenementModel.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                  ),

                  // Description
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

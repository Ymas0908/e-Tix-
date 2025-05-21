import 'package:flutter/material.dart';
import 'package:my_app/models/evenement_model.dart';
import 'package:my_app/views_model/evenement_viewmodel.dart';
import 'package:provider/provider.dart';


class CardEvenement extends StatefulWidget {
  const CardEvenement({
    super.key,
    required this.evenementModel,
    this.icon,
  });

  final EvenementModel evenementModel;
  final Icon? icon;

  @override
  State<CardEvenement> createState() => _CardEvenementState();
}

class _CardEvenementState extends State<CardEvenement> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EvenementViewModel>(builder: (context, evenementViewModel, _) {

      return SizedBox(
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            // side: BorderSide(
            //   width: 0.5,
            //   // color: AppColors.gimpPayBlue100,
            // ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),

                // Contenu texte
                Text(
                  widget.evenementModel.libelle! ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    widget.evenementModel.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

}

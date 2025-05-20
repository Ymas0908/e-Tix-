import 'package:flutter/material.dart';
import 'package:my_app/models/evenement_model.dart';
import 'package:my_app/views_model/evenement_viewmodel.dart';
import 'package:provider/provider.dart';

class CardEvenement extends StatefulWidget {
  const CardEvenement({
    super.key,
    required this.evenementModel,
  });

  final EvenementModel evenementModel;

  @override
  State<CardEvenement> createState() => _CardEvenementState();
}

class _CardEvenementState extends State<CardEvenement> {
  @override
  Widget build(BuildContext context) {
    final evenementViewModel =
    Provider.of<EvenementViewModel>(context, listen: false);

    return SizedBox(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.5,
            color: Colors.blueGrey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image et bouton + alignés
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (evenementViewModel.listeStubs.isNotEmpty &&
                      evenementViewModel.selectedEvenement != null)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Center(
                          child: evenementViewModel.selectedEvenement!.typeEvenement ==
                              "CONCERT"
                              ? const Icon(
                            Icons.taxi_alert,
                            size: 24,
                            color: Colors.white38,
                          )
                          //     : acceuilViewModel.selectedMmp!.typeMmp == "VTC"
                          //     ? const Icon(
                          //   Icons.directions_car,
                          //   size: 24,
                          //   color: AppColors.gimpPayYellow,
                          // )
                          //     : acceuilViewModel.selectedMmp!.typeMmp ==
                          //     "PRODUITS_SERVICES"
                          //     ? const Icon(
                          //   Icons.shopping_bag_outlined,
                          //   size: 24,
                          //   color: AppColors.gimpPayYellow,
                          // )
                          //     : acceuilViewModel.selectedMmp!.typeMmp ==
                          //     "BANQUE"
                          //     ? const Icon(
                          //   Icons.account_balance_outlined,
                          //   size: 24,
                          //   color: AppColors.gimpPayYellow,
                          // )
                              : const SizedBox
                              .shrink(), // Affiche rien
                        ),
                      ),
                    ),
                  // if (acceuilViewModel.contributeurs.isNotEmpty &&
                  //     acceuilViewModel.selectedMmp?.typeMmp ==
                  //         "PRODUITS_SERVICES")
                  //   IconButton(
                  //     onPressed: () {
                  //       acceuilViewModel.ajouterAuPanier(
                  //         nom: '',
                  //         prix: 0,
                  //       );
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         const SnackBar(
                  //           content: Text("Ajouté au panier ."),
                  //           backgroundColor: Colors.green,
                  //           behavior: SnackBarBehavior.floating,
                  //           duration: Duration(seconds: 2),
                  //         ),
                  //       );
                  //     },
                  //     icon: const Icon(
                  //       Icons.add,
                  //       color: Color(0xFF283478),
                  //     ),
                  //   ),
                ],
              ),
              const SizedBox(height: 50),

              Text(
                evenementViewModel.selectedEvenement!.nom ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: Text(
                  evenementViewModel.selectedEvenement?.description ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveGrid({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;

    // Définir dynamiquement le nombre de colonnes


    // Espacement et marges pour un affichage équilibré
    const double spacing = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Marges latérales
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: spacing, // Espacement horizontal
          mainAxisSpacing: spacing,  // Espacement vertical
          childAspectRatio: 0.75,    // Proportion largeur/hauteur
        ),
        itemCount: children.length,
        itemBuilder: (context, index) {
          return children[index];
        },
      ),
    );
  }
}

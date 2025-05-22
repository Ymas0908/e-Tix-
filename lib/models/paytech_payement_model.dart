import 'dart:ffi';

class PaytechPayementModel {
  String? nomProduit;
  Double? prixProduit;
   String? devise;
  String? descriptionProduit;
  String? refCommande;


PaytechPayementModel({
  required this.nomProduit,
  required this.prixProduit,
  required this.devise,
  required this.descriptionProduit,
  required this.refCommande,
});
 factory PaytechPayementModel.fromJson(Map<String, dynamic> json) {
    return PaytechPayementModel(
      nomProduit: json['nomProduit'],
      prixProduit: json['prixProduit'],
      devise: json['devise'],
      descriptionProduit: json['descriptionProduit'],
      refCommande: json['refCommande'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomProduit': nomProduit,
      'prixProduit': prixProduit,
      'devise': devise,
      'descriptionProduit': descriptionProduit,
      'refCommande': refCommande,
    };
  }
}
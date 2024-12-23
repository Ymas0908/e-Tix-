import 'package:my_app/models/enum/type_evenement.dart';

import 'enum/type_evenement.dart';

class EvenementModel {
  int? id;
  String libelle;
  String? description;
String urlImage;
  DateTime dateEvenement;
  TypeEvenement typeEvenement;
  String lieu;
  String promotteur;

  EvenementModel(
      {required this.libelle,
      required this.description,
      required this.urlImage,
      required this.dateEvenement,
      required this.typeEvenement,
      required this.lieu,
      required this.promotteur,
      required this.id});

   factory EvenementModel.fromJson(Map<String, dynamic> json) {
    return EvenementModel(
      libelle: json['libelle'],
      description: json['description'],
      urlImage: json['urlImage'],
      dateEvenement: DateTime.parse(json['dateEvenement']),
      typeEvenement: stringToTypeEvenement(json['typeEvenement']),
      lieu: json['lieu'],
      promotteur: json['promotteur'],
      id: json['id'],
    );
  }
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['libelle'] = this.libelle;
      data['description'] = this.description;
      data['urlImage'] = this.urlImage;
      data['dateEvenement'] = this.dateEvenement;
      data['typeEvenement'] = this.typeEvenement;
      data['lieu'] = this.lieu;
      data['promotteur'] = this.promotteur;
      data['id'] = this.id;
      return data;
    }


  static TypeEvenement stringToTypeEvenement(String value) {
    switch (value) {
      case 'CONCERT':
        return TypeEvenement.CONCERT;
      case 'FESTIVAL':
        return TypeEvenement.FESTIVAL;
      case 'SPECTACLE':
        return TypeEvenement.SPECTACLE;
      case 'MATCH':
        return TypeEvenement.MATCH;
        case 'PARTY':
        return TypeEvenement.PARTY;
      default:
        throw Exception('Type d\'événement inconnu');
    }
  }

  static String? typeEvenementToString(TypeEvenement typeEvenement) {
    switch (typeEvenement) {
      case TypeEvenement.CONCERT:
        return 'CONCERT';
      case TypeEvenement.FESTIVAL:
        return 'FESTIVAL';
      case TypeEvenement.SPECTACLE:
        return 'SPECTACLE';
      case TypeEvenement.MATCH:
        return 'MATCH';
        case TypeEvenement.PARTY:
        return 'PARTY';
      default:
        return null; // Valeur par défaut en cas de type inconnu
    }
  }
}
import 'package:my_app/models/enum/type_evenement.dart';

import 'enum/type_evenement.dart';
import 'enum/type_ticket.dart';

class EvenementModel {
  int? id;
  String nom;
  String? description;
String lieu;
  DateTime dateEvenement;
  DateTime dateHeureCreation;
  TypeEvenement typeEvenement;



  EvenementModel({
    this.id,
    required this.nom,
    this.description,
    required this.lieu,
    required this.dateEvenement,
    required this.dateHeureCreation,
    required this.typeEvenement,
  });

  factory EvenementModel.fromJson(Map<String, dynamic> json) {
    return EvenementModel(
      id: json['id'],
      nom: json['nom'],
      description: json['description'],
      lieu: json['lieu'],
      dateEvenement: DateTime.parse(json['dateEvenement']),
      dateHeureCreation: DateTime.parse(json['dateHeureCreation']),
      typeEvenement: TypeEvenement.values
          .firstWhere((type) => type.name == json['typeEvenement']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'urlImage': lieu,
      'dateEvenement': dateEvenement.toIso8601String(),
      'dateHeureCreation': dateHeureCreation.toIso8601String(),
      'typeEvenement': typeEvenement.name,
    };
  }
  static TypeEvenement stringToTypeEvenement(String value) {
    switch (value) {
      case 'CONCERT':
        return TypeEvenement.CONCERT;
      case 'FESTIVAL':
        return TypeEvenement.FESTIVAL;
      case 'CINEMA':
        return TypeEvenement.CINEMA;
      case 'RELEASE_PARTY':
        return TypeEvenement.RELEASE_PARTY;
      case 'THEATRE':
        return TypeEvenement.THEATRE;
        case 'RELEASE_PARTY':
        return TypeEvenement.RELEASE_PARTY;
      case 'THEATRE':
        return TypeEvenement.THEATRE;
      default:
        throw Exception('Type d\'evenement inconnu');
    }
  }

  static String? typeEvenementToString(TypeEvenement typeEvenement) {
    switch (typeEvenement) {
      case TypeEvenement.CONCERT:
        return 'CONCERT';

      case TypeEvenement.FESTIVAL:
        return 'FESTIVAL';

      case TypeEvenement.THEATRE:
        return 'THEATRE';

      case TypeEvenement.MATCH:
        return 'MATCH';

      case TypeEvenement.RELEASE_PARTY:
        return 'RELEASE_PARTY';

        case TypeEvenement.CINEMA:
        return 'CINEMA';

        case TypeEvenement.EXPOSITION:
        return 'EXPOSITION';
      default:
        return null; // Valeur par défaut en cas de type inconnu
    }
  }

  static TypeTicket stringToTypeTicket(String value) {
    switch (value) {
      case 'GP':
        return TypeTicket.GP;
      case 'VIP':
        return TypeTicket.VIP;
      case 'VVIP':
        return TypeTicket.VVIP;
      default:
        throw Exception('Type de ticket inconnu');
    }
  }

  static String? typeTicketToString(TypeTicket typeTicket) {
    switch (typeTicket) {
      case TypeTicket.GP:
        return 'GP';
      case TypeTicket.VIP:
        return 'VIP';
      case TypeTicket.VVIP:
        return 'VVIP';
      default:
        return null; // Valeur par défaut en cas de type inconnu
    }
  }
}
import 'package:eTix/models/enum/type_ticket.dart';

class TicketModel {
  final int? id;
  final String? reference;
  final String? prix;
  final int? quantite;
  final TypeTicket typeTicket;
  final DateTime? dateHeureCreation;

  TicketModel({
    required this.id,
    required this.reference,
    required this.prix,
    required this.quantite,
    required this.typeTicket,
    required this.dateHeureCreation,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as int,
      reference: json['reference'] as String,
      prix: json['prix'] as String,
      quantite: json['quantite'] as int,
      typeTicket: json['typeTicket'] as TypeTicket,
      dateHeureCreation: DateTime.parse(json['dateHeureCreation']),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'prix': prix,
      'quantite': quantite,
      'typeTicket': typeTicket,
      'dateHeureCreation': dateHeureCreation,
    };
  }

}

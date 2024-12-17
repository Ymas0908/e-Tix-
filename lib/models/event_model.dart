import 'enumeration/type_event.dart';
class EventModel {
  String? nom;
  String? lieu;
  String? date;
TypeEvent? typeEvenement;
  EventModel({this.nom, this.lieu, this.date, this.typeEvenement});

  EventModel.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    lieu = json['lieu'];
    date = json['date'];
    typeEvenement = stringToTypeEvent(json['typeEvenement']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['lieu'] = this.lieu;
    data['date'] = this.date;
    data['typeEvenement'] = this.typeEvenement;
    return data;
  }

  TypeEvent? stringToTypeEvent(String typeEvenement) {
    switch (typeEvenement) {
      case 'CONCERT':
        return TypeEvent.CONCERT;
      case 'CINEMA':
        return TypeEvent.CINEMA;
      case 'THEATRE':
        return TypeEvent.THEATRE;
      default:
        return null;
    }
  }
String? typeEventToString(TypeEvent typeEvenement) {
    switch (typeEvenement) {
      case TypeEvent.CONCERT:
        return 'CONCERT';
      case TypeEvent.CINEMA:
        return 'CINEMA';
      case TypeEvent.THEATRE:
        return 'THEATRE';
      default:
        return null;
    }
  }
}
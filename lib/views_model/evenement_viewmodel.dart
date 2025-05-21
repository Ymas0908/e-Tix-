import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/models/enum/type_evenement.dart';
import 'package:my_app/web_services/services/evenement_service.dart';
import 'package:my_app/web_services/services/paytech_sayement_service.dart';
import 'package:provider/provider.dart';

import '../models/evenement_model.dart';


class EvenementViewModel extends ChangeNotifier {
  final EvenementService evenementService;
  final PaytechPaymentService paymentService;

  EvenementViewModel({
    required this.paymentService, required this.evenementService});

  bool _isEventLoading = false;

  bool get isEventLoading => _isEventLoading;


  // void _seEventLoading(bool value) {
  //   _isEventLoading = value;
  //   notifyListeners();
  // }

  final TextEditingController searchEventController = TextEditingController();
  List<EvenementModel> evenements = [];
  List<EvenementModel> _allEvenements = [];

  EvenementModel? selectedEvenement;

  // List<TypeTicket> TypeTickets = [];


  void setSelectedEvenement(EvenementModel evenement) {
    selectedEvenement = evenement;
    notifyListeners();
  }


  Future<void> getAllEvenements() async {
    try {
      await evenementService.getAllEvenements();
      notifyListeners();
      print(evenements.length.toString() + "   récupérés avec succès");
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
    }
  }

  Future<void> getLesEvenementsByNom(BuildContext context) async {
    try {
      String? nom = context
          .read<EvenementViewModel>()
          .selectedEvenement
          ?.nom;

      await evenementService.getLesEvenementsByNom(nom ?? '');
      notifyListeners();
      print(evenements.length.toString() + "   récupérés avec succès");
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
    }
  }


  Future<void> getEvenementBylibelle(BuildContext context) async {
    try {
      String? libelle = context
          .read<EvenementViewModel>()
          .selectedEvenement
          ?.libelle;
      await evenementService.getEvenementBylibelle(libelle ?? '');
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
    }


    Future<void> initierPaiement(BuildContext context) async {
      try {
        await paymentService.initierPaiement;
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print("Une erreur s'est produite: $e");
        }
      }
    }
  }

  Future<void> filterEvenements(String searchTerm) async {
    try {
      final term = searchTerm.trim().toLowerCase();
      print("Term: $term");
      print("evenements length: ${evenements.length}");
      print("m_evenements.length: ${evenements.length}");
      if (term.isEmpty) {
        evenements = [..._allEvenements];
      } else {
        evenements = _allEvenements.where((event) {
          final libelle = event.libelle?.toLowerCase() ?? '';
          return libelle.contains(term);
        }).toList();
      }
    } catch (e) {
      debugPrint('Erreur lors du filtrage: $e');
      evenements = [..._allEvenements];
    } finally {
      notifyListeners();
    }
  }


  List<EvenementModel> listeStubs = [
    EvenementModel(
      id: 1,
      nom: "Concert Magic System",
      dateEvenement: DateTime(2025, 6, 15, 20, 0),
      prixTicketGP: "5000",
      prixTicketVIP: "15000",
      prixTicketVVIP: "30000",
      dateHeureCreation: DateTime.now(),
      typeEvenement: TypeEvenement.CONCERT,
      urlImage: "https://example.com/images/magic-system.jpg",
      libelle: "Magic System Live",
      lieu: "Palais de la Culture, Abidjan",
      description: "Vivez une soirée inoubliable avec Magic System en live.",
    ),
    EvenementModel(
      id: 2,
      nom: "Festival de la bière",
      dateEvenement: DateTime(2025, 7, 2, 18, 0),
      prixTicketGP: "3000",
      prixTicketVIP: "10000",
      prixTicketVVIP: "20000",
      dateHeureCreation: DateTime.now(),
      typeEvenement: TypeEvenement.FESTIVAL,
      urlImage: "https://example.com/images/festival-biere.jpg",
      libelle: "Bière Fest 2025",
      lieu: "Parc des Sports, Treichville",
      description: "Des dégustations de bières locales et internationales, concerts et animations.",
    ),
    EvenementModel(
      id: 3,
      nom: "Finale Coupe Nationale",
      dateEvenement: DateTime(2025, 8, 20, 17, 0),
      prixTicketGP: "2000",
      prixTicketVIP: "5000",
      prixTicketVVIP: "10000",
      dateHeureCreation: DateTime.now(),
      typeEvenement: TypeEvenement.MATCH,
      urlImage: "https://example.com/images/finale-coupe.jpg",
      libelle: "Finale Football",
      lieu: "Stade Olympique d'Ebimpé",
      description: "Les deux meilleures équipes s'affrontent pour le titre national.",
    ),
  ];
}

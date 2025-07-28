import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';

import '../models/enum/type_evenement.dart';
import '../models/enum/type_ticket.dart';
import '../models/evenement_model.dart';
import '../models/ticket_model.dart';
import '../web_services/services/evenement_service.dart';
import '../web_services/services/tickets_service.dart';


class EvenementViewModel extends ChangeNotifier {
  final EvenementService evenementService;
  final TicketService ticketService;

  EvenementViewModel({required this.evenementService, required this.ticketService});

  bool _isEventLoading = false;

  bool get isEventLoading => _isEventLoading;


  // void _seEventLoading(bool value) {
  //   _isEventLoading = value;
  //   notifyListeners();
  // }

  final TextEditingController searchEventController = TextEditingController();
  final TextEditingController prixTicketController = TextEditingController();
  List<EvenementModel> evenements = [];
  List<EvenementModel> _allEvenements = [];
  List<TypeEvenement> listTypeEvenement = [
    TypeEvenement.MATCH,
    TypeEvenement.THEATRE,
    TypeEvenement.CINEMA,
    TypeEvenement.EXPOSITION,
    TypeEvenement.CONCERT,
    TypeEvenement.FESTIVAL,
    TypeEvenement.RELEASE_PARTY
  ];
  List<TypeTicket> listTypeTicket = [
    TypeTicket.GP,
    TypeTicket.VIP,
    TypeTicket.VVIP
  ];
  List<TicketModel> tickets = [];



  EvenementModel? selectedEvenement;
  TicketModel? selectedTicket;
  TypeEvenement? selectedTypeEvenement;
  TypeTicket? selectedTypeTicket;


  /**
   * Cette méthode permet de collecter le prix d'un ticket en fonction du type de ticket sélectionné.
   */
  void setSelectedTypeTicket(TypeTicket typeTicket) {
    selectedTypeTicket = typeTicket;
    if (selectedEvenement != null) {
      switch (typeTicket) {
        case TypeTicket.GP:
          prixTicketController.text = selectedEvenement!.prixTicketGP ?? '';
          break;
        case TypeTicket.VIP:
          prixTicketController.text = selectedEvenement!.prixTicketVIP ?? '';
          break;
        case TypeTicket.VVIP:
          prixTicketController.text = selectedEvenement!.prixTicketVVIP ?? '';
          break;
      }
    }

    notifyListeners();
  }


  void setSelectedEvenement(EvenementModel evenement) {
    selectedEvenement = evenement;
    selectedTypeTicket = null;
    prixTicketController.clear();

    notifyListeners();
  }

  /**
   * Cette méthode permet de récupérer tous les tickets disponibles.
   */

  Future<void> getAllTickets(BuildContext context) async {
    try {
      tickets = await ticketService.getAllTickets();
      notifyListeners();
      print(tickets.length.toString() + " tickets récupérés avec succès");
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
    }
  }

  /**
   * Cette méthode permet de récupérer tous les événements disponibles.
   */
  Future<void> getAllEvenements(BuildContext context) async {

    try {
      _isEventLoading = true;
      notifyListeners();
      evenements = await evenementService.getAllEvenements();
      print('${evenements.length} événements récupérés avec succès');
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
    } finally {
      _isEventLoading = false;
      notifyListeners();
    }
  }


  Future<void> getLesEvenementsByNom(BuildContext context) async {
    try {
      String? nom = context.read<EvenementViewModel>().selectedEvenement?.nom;

      evenements = await evenementService.getLesEvenementsByNom(nom ?? '');
      notifyListeners();
      print(evenements.length.toString() + "  événements récupérés avec succès");
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
       evenements = await evenementService.getEvenementBylibelle(libelle ?? '');
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
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


}

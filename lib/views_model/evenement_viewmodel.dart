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

void setSelectedTicket(TicketModel ticket) {
  selectedTicket = ticket;
  notifyListeners();
  selectedTicket = null;
}
  // List<TypeTicket> TypeTickets = [];
void setSelectedTypeTicket(TypeTicket typeTicket) {
  selectedTypeTicket = typeTicket;
  notifyListeners();
}
void setSelectedTypeEvenement(TypeEvenement typeEvenement) {
  selectedTypeEvenement = typeEvenement;
  notifyListeners();
}
  void setSelectedEvenement(EvenementModel evenement) {
    selectedEvenement = evenement;
    selectedTypeTicket = null;

    notifyListeners();
  }


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

  Future<void> getAllEvenements( BuildContext context) async {
    try {
      evenements = await evenementService.getAllEvenements();
      notifyListeners();
      print(evenements.length.toString() + " événements récupérés avec succès");
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
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

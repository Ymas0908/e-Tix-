import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:my_app/models/enum/type_ticket.dart';

import '../models/evenement_model.dart';
import '../repository/api_rest/evenements/evenement_impl.dart';
import '../repository/api_rest/evenements/evenement_repo.dart';
import '../repository/network/response.dart';

class EvenementViewModel extends ChangeNotifier {
  final IEvenementRepository evenementRepository = EvenementImpl();
  TextEditingController nomEvenement = TextEditingController();

  bool isLoading = false;
  Failure? error;


  List<EvenementModel> evenements = [];
  // List<TypeTicket> TypeTickets = [];



Future<void> getAllEvenements() async {
  var response = await evenementRepository.getAllEvenements();
  response.fold(
        (l) {
      error = l as Failure?;
      print('Error: $error');
      isLoading = false;
      notifyListeners();
    },
        (r) {
          evenements = r.cast<EvenementModel>(); //
      isLoading = false; //

      notifyListeners(); //
    },
  );
}

Future<void> getLesEvenementsByNom(String nom) async {
  var response = await evenementRepository.getLesEvenementsByNom(nom);
  response.fold(
        (l) {
      error = l as Failure?;
      print('Error: $error');
      isLoading = false;
      notifyListeners();
    },
        (r) {
          evenements = r.cast<EvenementModel>(); //
      isLoading = false; //

      notifyListeners(); //
    },
  );
}


  // Future<void> getEvenementBylibelle(String libelle) async {
  //   var response = await evenementRepository.getEvenementBylibelle(libelle);
  //   response.fold(
  //         (l) {
  //       error = l as Failure?;
  //       print('Error: $error');
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //         (r) {
  //           evenements2 = r; //
  //       isLoading = false; //
  //
  //       notifyListeners(); //
  //     },
  //   );
  //   print('evenements : ${evenements.length}');
  // }

  // Future<void> getEvenementByTypeTicket(int idEvenement) async {
  //   var response = await evenementRepository.getEvenementByTypeTicket(idEvenement);
  //   response.fold(
  //         (l) {
  //       error = l as Failure?;
  //       print('Error: $error');
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //         (r) {
  //           TypeTickets = r.cast<TypeTicket>(); //
  //       isLoading = false; //
  //
  //       notifyListeners(); //
  //     },
  //   );
  //   print('evenements : ${evenements.length}');
  // }
}

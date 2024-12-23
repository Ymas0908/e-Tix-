import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';

import '../models/evenement_model.dart';
import '../repository/api_rest/evenements/evenement_impl.dart';
import '../repository/api_rest/evenements/evenement_repo.dart';
import '../repository/network/response.dart';

class EvenementViewModel extends ChangeNotifier {
  final IEvenementRepository evenementRepository = EvenementImpl();
  TextEditingController libelleEvenement = TextEditingController();

  bool isLoading = false;
  Failure? error;


  List<EvenementModel> evenements = [];
  List<EvenementModel> evenements2 = [];



  Future<void> getEvenements(int idEvenement) async {
    var response = await evenementRepository.getEvenements(idEvenement);
    response.fold(
          (l) {
        error = l as Failure?;
        print('Error: $error');
        isLoading = false;
        notifyListeners();
      },
          (r) {
        evenements = r; //
        isLoading = false; //

        notifyListeners(); //
      },
    );
    print('evenements : ${evenements.length}');
  }

  Future<void> getEvenementBylibelle(String libelle) async {
    var response = await evenementRepository.getEvenementBylibelle(libelle);
    response.fold(
          (l) {
        error = l as Failure?;
        print('Error: $error');
        isLoading = false;
        notifyListeners();
      },
          (r) {
            evenements2 = r; //
        isLoading = false; //

        notifyListeners(); //
      },
    );
    print('evenements : ${evenements.length}');
  }
}

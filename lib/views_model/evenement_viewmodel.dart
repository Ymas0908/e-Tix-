import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';

import '../models/evenement_model.dart';
import '../repository/api_rest/evenements/evenement_impl.dart';
import '../repository/api_rest/evenements/evenement_repo.dart';
import '../repository/network/response.dart';

class EvenementViewModel extends ChangeNotifier {
  final IEvenementRepository evenementRepository = EvenementImpl();
  bool isLoading = false;
  Failure? error;


  List<EvenementModel> evenements = [];



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
}

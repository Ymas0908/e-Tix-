import 'dart:core';
import 'dart:core';

import 'package:auth_firebase/models/event_model.dart';
import 'package:auth_firebase/repository/api_rest/evenements/event_repo.dart';
import 'package:flutter/cupertino.dart';

import '../repository/api_rest/evenements/event_impl.dart';
import '../repository/network/response.dart';

class EvenementViewModel extends ChangeNotifier {
  final IEvenementRepository evenementRepository = EvenementImpl();
  bool isLoading = false;
  Failure? error;

  List<EventModel> evenementavenir = [];
  List<EventModel> evenementpopulaires = [];

  Future<void> getEvenementavenir(int idEvenement) async {
    var response = await evenementRepository.getEvenementavenir(idEvenement);
    response.fold(
            (l) {
          error = l as Failure;
          isLoading = false;
          notifyListeners();
        },
            (r) {
          evenementavenir = r;
          isLoading = false;
          notifyListeners();
        }
    );
  }

  Future<void> getEvenementpopulaire(int idEvenement) async {
    var response = await evenementRepository.getEvenementpopulaire(idEvenement);
    response.fold(
            (l) {
          error = l as Failure;
          isLoading = false;
          notifyListeners();
        },
            (r) {
          evenementpopulaires = r;
          isLoading = false;
          notifyListeners();
        }
    );
  }
}
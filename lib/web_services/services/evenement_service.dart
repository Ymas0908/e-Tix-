import 'dart:async';
import 'dart:core';

import '../../models/evenement_model.dart';

abstract class EvenementService {



  Future<List<EvenementModel>> getAllEvenements();
  Future<List<EvenementModel>> getLesEvenementsByNom(String nom);
  Future<List<EvenementModel>> getEvenementBylibelle(String libelle);



}

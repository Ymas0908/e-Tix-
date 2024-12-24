import 'package:either_dart/either.dart';

import '../../../models/evenement_model.dart';


abstract class IEvenementRepository {


  Future<Either<Object, List<EvenementModel>>> getEvenements(int idEvenement);

  Future<Either<Object, List<EvenementModel>>> getEvenementBylibelle(String libelle);


}

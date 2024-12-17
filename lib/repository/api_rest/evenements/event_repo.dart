import 'package:auth_firebase/models/event_model.dart';
import 'package:either_dart/either.dart';


abstract class IEvenementRepository {
  Future<Either<Object, List<EventModel>>> getEvenementavenir(int idEvenement);

  Future<Either<Object, List<EventModel>>> getEvenementpopulaire(int idEvenement);

  Future<Either<Object, List<EventModel>>> getLesEvenements(int idEvenement);


}

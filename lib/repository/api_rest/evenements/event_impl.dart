import 'package:auth_firebase/models/event_model.dart';

import 'package:either_dart/src/either.dart';

import 'event_repo.dart';

class EvenementImpl implements IEvenementRepository {
  @override
  Future<Either<Object, List<EventModel>>> getEvenementavenir(int idEvenement) {
    // TODO: implement getEvenementavenir
    throw UnimplementedError();
  }

  @override
  Future<Either<Object, List<EventModel>>> getEvenementpopulaire(int idEvenement) {
    // TODO: implement getEvenementpopulaire
    throw UnimplementedError();
  }
}
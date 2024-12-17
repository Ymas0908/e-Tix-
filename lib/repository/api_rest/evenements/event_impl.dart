import 'package:auth_firebase/models/event_model.dart';

import 'package:either_dart/src/either.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../network/response.dart';
import 'event_repo.dart';

class EvenementImpl implements IEvenementRepository {

  String baseUrl = "http://10.0.2.2:8011/gimNotify/notifications/v1";
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

  @override
  Future<Either<Object, List<EventModel>>> getLesEvenements(int idEvenement) async {
    try{
      String url = "$baseUrl/getLesEvenements/$idEvenement";
      http.Response response = await http.get(Uri.parse(url));
      if ( response.statusCode == 200 ) {
        print("*******succes: ${response.body}");
        final data = json.decode(response.body);


        return Right(List<EventModel>.from(data.map((x) => EventModel.fromJson(x))));
      } else {
        print('*******error: ${response.body}');
        return Left(Failure(code: response.statusCode, message: "Error"));
      }
    } on Exception catch (e) {

      return Left(Failure(code: 0, message: e.toString()));

    }
  }
}
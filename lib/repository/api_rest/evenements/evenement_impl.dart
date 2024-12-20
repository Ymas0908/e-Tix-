
import 'package:either_dart/src/either.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/evenement_model.dart';
import '../../network/response.dart';
import 'evenement_repo.dart';

class EvenementImpl implements IEvenementRepository {

  String baseUrl = "http://10.0.2.2:8080/etix/evenements/v1";

  @override
  Future<Either<Object, List<EvenementModel>>> getEvenements(int idEvenement) async {
    try{
      String url = "$baseUrl/getEvenements/$idEvenement";
      http.Response response = await http.get(Uri.parse(url));
      if ( response.statusCode == 200 ) {
        print("*******succes: ${response.body}");
        final data = json.decode(response.body);
        return Right(List<EvenementModel>.from(data.map((x) => EvenementModel.fromJson(x))));
      } else {
        print('*******error: ${response.statusCode}');
        return Left(Failure(code: response.statusCode, message: "Error"));
      }
    } on Exception catch (e) {

      return Left(Failure(code: 0, message: e.toString()));

    }
  }


}
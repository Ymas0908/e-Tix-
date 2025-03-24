
import 'package:either_dart/src/either.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/enum/type_ticket.dart';
import 'dart:convert';
import '../../../models/evenement_model.dart';
import '../../network/response.dart';
import 'evenement_repo.dart';

class EvenementImpl implements IEvenementRepository {

  String baseUrl = "http://10.0.2.2:9000/etix/evenement/v1";


  @override
  /**
   * Cette fonction permet de recuperer tous les evenements
   */
    Future<Either<Object, List<EvenementModel>>> getAllEvenements() async {
    try{
      String url = "$baseUrl/getAllEvenements";
      http.Response response = await http.get(Uri.parse(url));
      if ( response.statusCode == 200 ) {
        print("*******succes: ${response.body}");
        Map<String, dynamic> data  = json.decode(response.body);
        return Right(List<EvenementModel>.from(data["body"].map((x) => EvenementModel.fromJson(x))));
      } else {
        print('*******error: ${response.statusCode}');
        return Left(Failure(code: response.statusCode, message: "Error"));
      }
    } on Exception catch (e) {
      print("*******exeption: ${e.toString()}");
      return Left(Failure(code: 0, message: e.toString()));
    }
    }

  @override
  Future<Either<Object, List<EvenementModel>>> getLesEvenementsByNom(String nom) async {

    try{
      String url = "$baseUrl/getLesEvenementsByNom/$nom";
      http.Response response = await http.get(Uri.parse(url));
      if ( response.statusCode == 200 ) {
        print("*******succes: ${response.body}");
        Map<String, dynamic> data  = json.decode(response.body);
        return Right(List<EvenementModel>.from(data["body"].map((x) => EvenementModel.fromJson(x))));
      } else {
        print('*******error: ${response.statusCode}');
        return Left(Failure(code: response.statusCode, message: "Error"));
      }
    } on Exception catch (e) {
      print("*******exeption: ${e.toString()}");
      return Left(Failure(code: 0, message: e.toString()));
    }
  }


  }








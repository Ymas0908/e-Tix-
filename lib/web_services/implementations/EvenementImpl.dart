import '../../models/evenement_model.dart';
import '../../utils/const.dart';
import 'package:http/http.dart' as http;
import '../../utils/execption/execption.dart';
import '../../utils/secure_storage.dart';
import '../services/evenement_service.dart';
import 'dart:convert';


class Evenementimpl implements EvenementService {
  @override


  @override
  Future<List<EvenementModel>> getEvenementBylibelle(String libelle) {
   try {
     // String? token = await getToken();
     Map<String, String> headers = {
       'Content-Type': 'application/json',
       // 'Authorization': 'Bearer $token',
     };
     String url = "$baseUrl/evenements/$libelle";
     return http.get(Uri.parse(url), headers: headers).then((response) {
       int statusCode = response.statusCode;
       print("body: ${response.body}");
       if (statusCode == 200) {
         // Operation retrieved successfully
         Map<String, dynamic> body = json.decode(response.body);
         List<dynamic> data = body['body'];
         return data.map((e) => EvenementModel.fromJson(e)).toList();
       }
         else if (statusCode == 404) {
         // Operation not found
         throw NotFoundException();
       } else if (statusCode == 500) {
         // Internal server error
         throw ServerException();
       } else if (statusCode == 401) {
         // Unauthorized access
         throw UnauthorizedException();
       } else if (statusCode == 403) {
         // Forbidden access
         throw ForbiddenException();
       } else if (statusCode == 400) {
         // Bad request
         throw BadRequestException();
       } else {
         // Handle error
         throw Exception("Une erreur s'est produite: ${response.body}");
       }
     });
   } catch (e) {
     rethrow;
   }
  }

  @override
  Future<List<EvenementModel>> getLesEvenementsByNom(String nom) {
    // TODO: implement getLesEvenementsByNom
    throw UnimplementedError();
  }

  @override
  Future<List<EvenementModel>> getAllEvenements() async {
    try {
      // String? token = await getToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      };
      String url = "$baseUrl/evenements";
      return http.get(Uri.parse(url), headers: headers).then((response) {
        int statusCode = response.statusCode;
        print("Success event body: ${response.body}");
        if (statusCode == 200) {

          Map<String, dynamic> body = json.decode(response.body);
          List<dynamic> data = body['body'];
          return data.map((e) => EvenementModel.fromJson(e)).toList();
        }
        else if (statusCode == 404) {
          // Operation not found
          throw NotFoundException();
        } else if (statusCode == 500) {
          // Internal server error
          throw ServerException();
        } else if (statusCode == 401) {
          // Unauthorized access
          throw UnauthorizedException();
        } else if (statusCode == 403) {
          // Forbidden access
          throw ForbiddenException();
        } else if (statusCode == 400) {
          // Bad request
          throw BadRequestException();
        } else {
          // Handle error
          throw Exception("Une erreur s'est produite: ${response.body}");
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  }




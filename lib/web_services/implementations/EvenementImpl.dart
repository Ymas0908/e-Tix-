import 'dart:convert';
import 'package:my_app/models/evenement_model.dart';
import '../../utils/const.dart';
import 'package:http/http.dart' as http;
import '../../utils/execption/execption.dart';
import '../services/evenement_service.dart';

class Evenementimpl implements EvenementService {
  @override
  Future<List<EvenementModel>> getAllEvenements() async {
    return _fetchEvenements('$baseUrl/getAllEvenements');
  }

  @override
  Future<List<EvenementModel>> getEvenementBylibelle(String libelle) async {
    return _fetchEvenements('$baseUrl/getLesEvenementsByLibelle/$libelle');
  }

  @override
  Future<List<EvenementModel>> getLesEvenementsByNom(String nom) async {
    return _fetchEvenements('$baseUrl/getLesEvenementsByNom/$nom');
  }

  Future<List<EvenementModel>> _fetchEvenements(String url) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final response = await http.get(Uri.parse(url), headers: headers);

      final statusCode = response.statusCode;
      final decoded = json.decode(utf8.decode(response.bodyBytes));

      if (statusCode == 200) {
        print("Événements récupérés avec succès (${response.statusCode})");

        final body = decoded['body'];
        if (body is List) {
          return body.map<EvenementModel>((item) => EvenementModel.fromJson(item)).toList();
        } else {
          throw Exception("Format inattendu dans 'body'");
        }
      }

      // Gérer les erreurs courantes
      switch (statusCode) {
        case 400:
          throw BadRequestException();
        case 401:
          throw UnauthorizedException();
        case 403:
          throw ForbiddenException();
        case 404:
          throw NotFoundException();
        case 500:
          throw ServerException();
        default:
          throw Exception("Erreur inconnue: ${response.body}");
      }
    } catch (e) {
      print("Erreur lors de la récupération des événements: $e");
      rethrow;
    }
  }
}

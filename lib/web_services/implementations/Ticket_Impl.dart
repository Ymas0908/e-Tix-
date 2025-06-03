import 'dart:convert';


import '../../models/ticket_model.dart';
import '../../utils/const.dart';
import '../services/tickets_service.dart';
import 'package:http/http.dart' as http;
import '../../utils/execption/execption.dart';

class TicketImpl implements TicketService {
  @override
  Future<List<TicketModel>> getAllTickets() async {
    try {
      // String? token = await getToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      };
      String url = "$baseUrl/tickets";
      return http.get(Uri.parse(url), headers: headers).then((response) {
        int statusCode = response.statusCode;
        print("Success fetch ticket : ${response.body}");
        if (statusCode == 200) {

          Map<String, dynamic> body = json.decode(response.body);
          List<dynamic> data = body['body'];
          return data.map((e) => TicketModel.fromJson(e)).toList();
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
  Future<List<TicketModel>> getTicketByUser(int idUser)async {
    try {
      // String? token = await getToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      };
      String url = "$baseUrl/tickets";
      return http.get(Uri.parse(url), headers: headers).then((response) {
        int statusCode = response.statusCode;
        print("Success fetch ticket : ${response.body}");
        if (statusCode == 200) {

          Map<String, dynamic> body = json.decode(response.body);
          List<dynamic> data = body['body'];
          return data.map((e) => TicketModel.fromJson(e)).toList();
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
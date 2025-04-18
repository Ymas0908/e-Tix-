import 'dart:convert';
import 'package:http/http.dart' as http;

class CinetPayService {
  static Future<String?> initierPaiement(int idTicket, String montant) async {
    final String apiUrl = "http://localhost:8080/paiement/initier/$idTicket/$montant";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print("URL de paiement : ${response.body}");
        return response.body; // L'URL de paiement CinetPay
      } else {
        throw Exception("Erreur lors de l'initiation du paiement");
      }
    } catch (e) {
      print("Erreur : $e");
      return null;
    }
  }
}

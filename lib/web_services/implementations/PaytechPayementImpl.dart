import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:my_app/models/enum/paytech_payement_model.dart';

import '../../utils/const.dart';
import '../services/paytech_sayement_service.dart';

class Paytechpayementimpl implements PaytechPaymentService {
  @override
  Future<void> initierPaiement(PaytechPayementModel paytechPayementModel) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };

      debugPrint("Request body operation: ${paytechPayementModel.toJson()}");

      final url = "$baseUrl/payment/request-payment";
      final body = jsonEncode(paytechPayementModel.toJson());

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        debugPrint("paiement initié: ${response.body}");
      } else {
        debugPrint(" error: ${response.statusCode}");
        debugPrint(" error: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error executing operation: $e");
      rethrow;
    }
  }

}
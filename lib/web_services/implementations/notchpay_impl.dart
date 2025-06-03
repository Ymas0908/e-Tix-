
import '../../models/notchpay_request_model.dart';
import '../../utils/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/execption/execption.dart';
import '../../utils/secure_storage.dart';
import '../services/notchPay_service.dart';

class NotchpayImpl implements NotchpayService {
  @override
  Future<void> initierPaiement(NotchPayRequest notchPayRequest) async {
    try {
      // String? token = await getToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      };
      String url = "$baseUrlNotchPay/payments";
      return http.post(Uri.parse(url), headers: headers).then((response) {
        int statusCode = response.statusCode;
        if (statusCode == 200) {
          // Operation retrieved successfully
          Map<String, dynamic> data = json.decode(response.body);
          return NotchPayRequest.fromJson(data);
        } else if (statusCode == 404) {
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
          throw Exception("Error: ${response.body}");
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
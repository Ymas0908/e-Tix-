import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../models/notchpay_request_model.dart';
import '../web_services/services/notchPay_service.dart';

class NotchpayViewmodel extends ChangeNotifier {

  final NotchpayService notchPayService;

  NotchpayViewmodel({required this.notchPayService});



  Future<void> initierPaiement(NotchPayRequest notchPayRequest) async {
    try {
      await notchPayService.initierPaiement(notchPayRequest);
      print("initierPaiement" + notchPayRequest.toString());
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
    }
  }

}
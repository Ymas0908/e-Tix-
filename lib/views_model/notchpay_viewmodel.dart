import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../models/notchpay_request_model.dart';
import '../web_services/services/notchPay_service.dart';

class NotchpayViewmodel extends ChangeNotifier {

  final NotchpayService notchPayService;

  NotchpayViewmodel({required this.notchPayService});



  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  Future<void> initierPaiement() async {
    try {
      final notchPayRequest = NotchPayRequest(
        amount: int.parse(amountController.text),
        description: descriptionController.text,
        reference: DateTime.now().millisecondsSinceEpoch.toString(), // ou autre générateur
        currency: 'XOF',
      );

      print("initierPaiement: $notchPayRequest");

      await notchPayService.initierPaiement(notchPayRequest); // Appel réel du service

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
    }
  }

}
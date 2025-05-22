import '../../models/notchpay_request_model.dart';

abstract class NotchpayService {
  Future<void> initierPaiement(NotchPayRequest notchPayRequest);
}
import 'package:my_app/models/enum/paytech_payement_model.dart';

abstract class PaytechPaymentService {
  Future<void> initierPaiement(PaytechPayementModel paytechPayementModel);

}
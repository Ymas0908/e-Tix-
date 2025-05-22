import 'customer_model.dart';

class NotchPayRequest {
  String? id;
  String? reference;
  int? amount;
  String? currency;
  Customer? customer;
  String? paymentMethod;
  String? description;
  String? createdAt;
  String? completedAt;

  NotchPayRequest({this.id, this.reference, this.amount, this.currency, this.customer, this.paymentMethod, this.description, this.createdAt, this.completedAt});

  NotchPayRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    amount = json['amount'];
    currency = json['currency'];
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    paymentMethod = json['payment_method'];
    description = json['description'];
    createdAt = json['created_at'];
    completedAt = json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['payment_method'] = this.paymentMethod;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['completed_at'] = this.completedAt;
    return data;
  }
}




Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
return data;
}

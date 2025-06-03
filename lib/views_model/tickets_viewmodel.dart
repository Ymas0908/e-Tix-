import 'package:flutter/material.dart';
import 'package:my_app/models/ticket_model.dart';
import 'package:my_app/web_services/services/tickets_service.dart';
import '../web_services/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class TicketsViewmodel extends ChangeNotifier {
  final TicketService ticketService;

  User? get user => FirebaseAuth.instance.currentUser;

  TicketsViewmodel({required this.ticketService});



  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

 List<TicketModel> tickets = [];

  Future<List<TicketModel>> getAllTickets() async {
    setLoading(true);
    tickets = await ticketService.getAllTickets();
    setLoading(false);
    return tickets;
  }
}
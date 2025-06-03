import '../../models/ticket_model.dart';

abstract class TicketService {
  Future<List<TicketModel>> getAllTickets();
  Future<List<TicketModel>> getTicketByUser(int idUser);
}

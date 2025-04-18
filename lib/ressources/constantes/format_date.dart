import 'package:intl/intl.dart';

String formatDate(var date) {
  // String dayOfWeek = DateFormat('EEEE', 'fr_FR').format(date).substring(0, 3);
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  return formattedDate;
}

String formatDateTime(var date) {
  // String dayOfWeek = DateFormat('EEEE', 'fr_FR').format(date).substring(0, 3);
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
  return formattedDate;
}
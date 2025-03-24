import 'package:intl/intl.dart';

String formatCurrency(double number) {
  // Définir le format pour les chiffres en francs CFA
  final format = NumberFormat.currency(
    locale: 'fr_FR',
    symbol: 'FCFA ',
    decimalDigits: 0,
  );
  return format.format(number);
}

import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String convertDateEpoch(dynamic date) {
    var dateVal = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    var d24 = DateFormat('dd/MM/yyyy').format(dateVal);
    return d24.toString();
  }
}
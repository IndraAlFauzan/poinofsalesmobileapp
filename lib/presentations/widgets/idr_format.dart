import 'package:intl/intl.dart';

String idrFormat(dynamic value) {
  double price;
  // Periksa tipe dari value dan konversi ke double jika perlu
  if (value is String) {
    price =
        double.tryParse(value) ??
        0; // Konversi string ke double, default ke 0 jika gagal
  } else if (value is int) {
    price = value.toDouble(); // Konversi int ke double
  } else {
    price = value; // Value sudah double
  }

  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 2,
  );
  return formatCurrency.format(price);
}

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formatDateTime(String dateTimeString) {
  try {
    // Inisialisasi lokal (wajib untuk bahasa non-Inggris)
    initializeDateFormatting('id_ID', null);
    Intl.defaultLocale = 'id_ID';

    // Konversi String ke DateTime
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();

    // Format tanggal: Senin, 11 Januari 2025, 17:46
    return DateFormat("EEEE, dd MMMM yyyy, HH:mm", 'id_ID').format(dateTime);
  } catch (e) {
    return "Format Tanggal Tidak Valid";
  }
}

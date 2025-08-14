import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';

class ReceiptPreviewDialog extends StatelessWidget {
  final dynamic transactionResponse;
  final double totalPrice;
  final int totalQty;
  final String paymentMethod;
  final String serviceType;
  final double? paymentAmount;
  final double? changeAmount;
  final List<Map<String, dynamic>>? items;

  const ReceiptPreviewDialog({
    super.key,
    required this.transactionResponse,
    required this.totalPrice,
    required this.totalQty,
    required this.paymentMethod,
    required this.serviceType,
    this.paymentAmount,
    this.changeAmount,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Nota Transaksi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Receipt Preview
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: _buildReceiptContent(context),
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        _copyToClipboard(context);
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: AppColors.primary),
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        _showPrintOptions(context);
                      },
                      icon: const Icon(Icons.print, color: Colors.white),
                      label: const Text(
                        'Print',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptContent(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Store Header
          Text(
            'POS MOBILE',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Jl. Contoh No. 123, Jakarta Selatan',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            'Telp: (021) 123-4567',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 20),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Transaction Info
          _buildInfoRow(
            theme,
            'No. Transaksi:',
            transactionResponse?.data?.orderNo != null
                ? '#${transactionResponse.data.orderNo}'
                : '#${now.millisecondsSinceEpoch % 100000}',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            theme,
            'Tanggal:',
            transactionResponse?.data?.createdAt != null
                ? '${transactionResponse.data.createdAt.day.toString().padLeft(2, '0')}/${transactionResponse.data.createdAt.month.toString().padLeft(2, '0')}/${transactionResponse.data.createdAt.year}'
                : '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            theme,
            'Waktu:',
            transactionResponse?.data?.createdAt != null
                ? '${transactionResponse.data.createdAt.hour.toString().padLeft(2, '0')}:${transactionResponse.data.createdAt.minute.toString().padLeft(2, '0')}:${transactionResponse.data.createdAt.second.toString().padLeft(2, '0')}'
                : '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            theme,
            'Tipe Layanan:',
            transactionResponse?.data?.serviceType?.toUpperCase() ??
                serviceType.toUpperCase(),
          ),
          // Tampilkan info meja jika ada
          if (transactionResponse?.data?.tableNo != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow(
              theme,
              'No. Meja:',
              transactionResponse!.data.tableNo,
            ),
          ],
          // Tampilkan info nama pelanggan jika ada
          if (transactionResponse?.data?.customerName != null &&
              transactionResponse!.data.customerName.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow(
              theme,
              'Nama Pelanggan:',
              transactionResponse!.data.customerName,
            ),
          ],

          const SizedBox(height: 20),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Items Header
          Text(
            'DETAIL PESANAN',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),

          // Items List
          if (items != null && items!.isNotEmpty) ...[
            ...items!.map(
              (item) => _buildReceiptItem(
                theme,
                item['name'] ?? 'Item',
                item['quantity'] ?? 1,
                (item['price'] ?? 0) is String
                    ? double.parse(item['price'] ?? '0')
                    : ((item['price'] ?? 0) as num).toDouble(),
                item['note'],
                item['flavor'],
                item['spicyLevel'],
              ),
            ),
          ] else ...[
            // Fallback untuk mock data
            ...List.generate(
              totalQty.clamp(1, 3),
              (index) => _buildReceiptItem(
                theme,
                'Item ${index + 1}',
                1,
                totalPrice / totalQty,
                null,
                null,
                null,
              ),
            ),
          ],

          const SizedBox(height: 16),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Totals
          _buildInfoRow(theme, 'Total Item:', '$totalQty item'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL:',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  idrFormat(totalPrice),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Footer
          Text(
            'Terima kasih atas kunjungan Anda!',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Barang yang sudah dibeli tidak dapat dikembalikan',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Simpan struk ini sebagai bukti pembelian',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptItem(
    ThemeData theme,
    String name,
    int qty,
    double price,
    String? note,
    String? flavor,
    String? spicyLevel,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text('${qty}x', style: theme.textTheme.bodyMedium),
              const SizedBox(width: 16),
              Text(
                idrFormat(price * qty),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // Tampilkan detail hanya jika ada data yang valid
          if (_hasValidDetails(flavor, spicyLevel, note)) ...[
            const SizedBox(height: 6),
            if (flavor != null && flavor.trim().isNotEmpty)
              Text(
                'Rasa: $flavor',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            if (spicyLevel != null && spicyLevel.trim().isNotEmpty)
              Text(
                'Level Pedas: $spicyLevel',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            if (note != null && note.trim().isNotEmpty)
              Text(
                'Catatan: $note',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ],
      ),
    );
  }

  // Helper method untuk mengecek apakah ada detail yang valid
  bool _hasValidDetails(String? flavor, String? spicyLevel, String? note) {
    return (flavor != null && flavor.trim().isNotEmpty) ||
        (spicyLevel != null && spicyLevel.trim().isNotEmpty) ||
        (note != null && note.trim().isNotEmpty);
  }

  void _copyToClipboard(BuildContext context) {
    final receiptText = _generateReceiptText();
    Clipboard.setData(ClipboardData(text: receiptText));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nota berhasil disalin ke clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showPrintOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Opsi Print',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Option 1: Screenshot
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.screenshot, color: AppColors.primary),
              ),
              title: const Text('Screenshot'),
              subtitle: const Text('Ambil screenshot untuk dibagikan'),
              onTap: () {
                HapticFeedback.selectionClick();
                Navigator.pop(context);
                _showScreenshotInstructions(context);
              },
            ),

            // Option 2: Copy Text
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.text_fields, color: AppColors.primary),
              ),
              title: const Text('Copy Text'),
              subtitle: const Text('Copy nota dalam format teks'),
              onTap: () {
                HapticFeedback.selectionClick();
                Navigator.pop(context);
                _copyToClipboard(context);
              },
            ),

            // Option 3: Future PDF (disabled for now)
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.picture_as_pdf, color: Colors.grey),
              ),
              title: const Text('Export PDF'),
              subtitle: const Text('Segera hadir - Export ke PDF'),
              enabled: false,
              onTap: null,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showScreenshotInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cara Screenshot'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Untuk mengambil screenshot nota:'),
            SizedBox(height: 12),
            Text('• Tutup dialog ini'),
            Text('• Ambil screenshot layar'),
            Text('• Crop bagian nota'),
            Text('• Share atau print dari galeri'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }

  String _generateReceiptText() {
    final now = DateTime.now();

    String receipt =
        '''
===============================
         POS MOBILE
   Jl. Contoh No. 123, Jakarta
     Telp: (021) 123-4567
===============================

No. Transaksi: ${transactionResponse?.data?.orderNo != null ? '#${transactionResponse.data.orderNo}' : '#${now.millisecondsSinceEpoch % 100000}'}
Tanggal: ${transactionResponse?.data?.createdAt != null ? '${transactionResponse.data.createdAt.day.toString().padLeft(2, '0')}/${transactionResponse.data.createdAt.month.toString().padLeft(2, '0')}/${transactionResponse.data.createdAt.year}' : '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}'}
Waktu: ${transactionResponse?.data?.createdAt != null ? '${transactionResponse.data.createdAt.hour.toString().padLeft(2, '0')}:${transactionResponse.data.createdAt.minute.toString().padLeft(2, '0')}:${transactionResponse.data.createdAt.second.toString().padLeft(2, '0')}' : '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}'}
Tipe Layanan: ${transactionResponse?.data?.serviceType?.toUpperCase() ?? serviceType.toUpperCase()}

===============================
        DETAIL PESANAN
===============================
''';

    if (items != null && items!.isNotEmpty) {
      for (var item in items!) {
        final name = item['name'] ?? 'Item';
        final qty = item['quantity'] ?? 1;
        final price = (item['price'] ?? 0) is String
            ? double.parse(item['price'] ?? '0')
            : ((item['price'] ?? 0) as num).toDouble();
        final total = price * qty;
        final flavor = item['flavor'];
        final spicyLevel = item['spicyLevel'];
        final note = item['note'];

        receipt += '${name.padRight(20)} ${qty}x\n';
        receipt += '${' ' * 20} ${idrFormat(total)}\n';

        // Tambahkan detail rasa, level pedas, dan catatan jika ada
        if (flavor != null && flavor.toString().trim().isNotEmpty) {
          receipt += '  Rasa: $flavor\n';
        }
        if (spicyLevel != null && spicyLevel.toString().trim().isNotEmpty) {
          receipt += '  Level Pedas: $spicyLevel\n';
        }
        if (note != null && note.toString().trim().isNotEmpty) {
          receipt += '  Catatan: $note\n';
        }
        receipt += '\n';
      }
    } else {
      // Mock data
      for (int i = 0; i < totalQty.clamp(1, 3); i++) {
        final price = totalPrice / totalQty;
        receipt += '${'Item ${i + 1}'.padRight(20)} 1x\n';
        receipt += '${' ' * 20} ${idrFormat(price)}\n\n';
      }
    }

    receipt +=
        '''
===============================
Total Item: $totalQty item
TOTAL: ${idrFormat(totalPrice)}

===============================
  Nota Untuk Dapur Sebagai
  Proses Pembuatan Pesanan
  
===============================
''';

    return receipt;
  }
}

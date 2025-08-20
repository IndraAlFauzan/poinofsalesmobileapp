import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/data/model/response/transaction_model.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class PaymentReceiptDialog extends StatelessWidget {
  final int paymentId;
  final List<Transaction> paidTransactions;
  final double totalAmount;
  final String paymentMethod;
  final double? tenderedAmount;
  final double? changeAmount;

  const PaymentReceiptDialog({
    super.key,
    required this.paymentId,
    required this.paidTransactions,
    required this.totalAmount,
    required this.paymentMethod,
    this.tenderedAmount,
    this.changeAmount,
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
                      'Struk Pembayaran',
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
    final now = DateTime.now();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Store Header
          Text(
            'POS MOBILE',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Jl. Contoh No. 123, Jakarta Selatan',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            'Telp: (021) 123-4567',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 20),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Payment Info
          _buildInfoRow(context, 'Payment ID:', paymentId.toString()),
          const SizedBox(height: 8),
          _buildInfoRow(
            context,
            'Tanggal:',
            '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            context,
            'Waktu:',
            '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}',
          ),

          const SizedBox(height: 20),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Transactions Header
          Text(
            'PESANAN YANG DIBAYAR',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),

          // Transactions List
          ...paidTransactions.map(
            (transaction) => _buildTransactionItem(context, transaction),
          ),

          const SizedBox(height: 16),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Totals
          _buildInfoRow(
            context,
            'Jumlah Transaksi:',
            '${paidTransactions.length} pesanan',
          ),
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
                  'TOTAL PEMBAYARAN:',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  idrFormat(totalAmount),
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Payment Info
          _buildInfoRow(context, 'Metode Bayar:', paymentMethod),

          if (tenderedAmount != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow(context, 'Bayar:', idrFormat(tenderedAmount!)),
          ],

          if (changeAmount != null && changeAmount! > 0) ...[
            const SizedBox(height: 8),
            _buildInfoRow(context, 'Kembalian:', idrFormat(changeAmount!)),
          ],

          const SizedBox(height: 24),
          Container(width: double.infinity, height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Footer
          Text(
            'Terima kasih atas kunjungan Anda!',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Barang yang sudah dibeli tidak dapat dikembalikan',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Simpan struk ini sebagai bukti pembayaran',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction transaction) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.orderNo,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Meja ${transaction.tableNo} - ${transaction.customerName}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                idrFormat(double.parse(transaction.grandTotal)),
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 8),
          Text(
            'Detail Pesanan:',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          ...transaction.details.map(
            (detail) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  Text('${detail.quantity}x '),
                  Expanded(child: Text(detail.productName)),
                  Text(
                    idrFormat(detail.subtotal),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    final receiptText = _generateReceiptText();
    Clipboard.setData(ClipboardData(text: receiptText));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Struk berhasil disalin ke clipboard'),
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
              subtitle: const Text('Copy struk dalam format teks'),
              onTap: () {
                HapticFeedback.selectionClick();
                Navigator.pop(context);
                _copyToClipboard(context);
              },
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
            Text('Untuk mengambil screenshot struk:'),
            SizedBox(height: 12),
            Text('• Tutup dialog ini'),
            Text('• Ambil screenshot layar'),
            Text('• Crop bagian struk'),
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

Payment ID: $paymentId
Tanggal: ${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}
Waktu: ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}

===============================
    PESANAN YANG DIBAYAR
===============================
''';

    for (var transaction in paidTransactions) {
      receipt += '${transaction.orderNo}\n';
      receipt += 'Meja ${transaction.tableNo} - ${transaction.customerName}\n';
      receipt +=
          'Total: ${idrFormat(double.parse(transaction.grandTotal))}\n\n';

      for (var detail in transaction.details) {
        receipt += '${detail.productName.padRight(20)} ${detail.quantity}x\n';
        receipt += '${' ' * 20} ${idrFormat(detail.subtotal)}\n';
      }
      receipt += '\n';
    }

    receipt +=
        '''
===============================
Jumlah Transaksi: ${paidTransactions.length} pesanan
TOTAL PEMBAYARAN: ${idrFormat(totalAmount)}
===============================

Metode Bayar: $paymentMethod''';

    if (tenderedAmount != null) {
      receipt += '\nBayar: ${idrFormat(tenderedAmount!)}';
    }

    if (changeAmount != null && changeAmount! > 0) {
      receipt += '\nKembalian: ${idrFormat(changeAmount!)}';
    }

    receipt += '''

===============================
   Terima kasih atas kunjungan!
 Barang yang sudah dibeli tidak
       dapat dikembalikan
===============================
''';

    return receipt;
  }
}

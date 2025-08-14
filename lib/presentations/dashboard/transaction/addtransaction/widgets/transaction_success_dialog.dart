import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/receipt_preview_dialog.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';

class TransactionSuccessDialog extends StatefulWidget {
  final dynamic transactionResponse;
  final double totalPrice;
  final int totalQty;
  final String? paymentMethodName;
  final String? serviceTypeName;
  final double? paymentAmount;
  final double? changeAmount;
  final List<Map<String, dynamic>>? cartItems;
  final VoidCallback? onHome;

  const TransactionSuccessDialog({
    super.key,
    required this.transactionResponse,
    required this.totalPrice,
    required this.totalQty,
    this.paymentMethodName,
    this.serviceTypeName,
    this.paymentAmount,
    this.changeAmount,
    this.cartItems,
    this.onHome,
  });

  @override
  State<TransactionSuccessDialog> createState() =>
      _TransactionSuccessDialogState();
}

class _TransactionSuccessDialogState extends State<TransactionSuccessDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start animations
    _scaleController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _showReceiptPreview(BuildContext context) {
    HapticFeedback.mediumImpact();

    // Use transaction response data if available, otherwise use cartItems
    List<Map<String, dynamic>> formattedItems = [];

    if (widget.transactionResponse != null &&
        widget.transactionResponse.data != null &&
        widget.transactionResponse.data.details != null) {
      // Use data from transaction response
      final transactionData = widget.transactionResponse.data;

      formattedItems = transactionData.details
          .map<Map<String, dynamic>>(
            (detail) => {
              'name': detail.nameProduct,
              'price': detail.price.toDouble(),
              'quantity': detail.quantity,
              'note': detail.note,
              'flavor': detail.flavor,
              'spicyLevel': detail.spicyLevel,
            },
          )
          .toList();
    } else {
      // Fallback to cartItems
      formattedItems =
          widget.cartItems?.map((item) {
            final product = item['product'];
            return {
              'name': product?.name ?? 'Unknown Product',
              'price': product?.price ?? 0.0,
              'quantity': item['quantity'] ?? 1,
              'note': item['note'],
              'flavor': item['selectedFlavor']?.name,
              'spicyLevel': item['selectedSpicyLevel']?.name,
            };
          }).toList() ??
          [];
    }

    showDialog(
      context: context,
      builder: (context) => ReceiptPreviewDialog(
        transactionResponse: widget.transactionResponse,
        totalPrice: widget.totalPrice,
        totalQty: widget.totalQty,
        paymentMethod: widget.paymentMethodName ?? 'Tunai',
        serviceType: widget.serviceTypeName ?? 'Dine In',
        paymentAmount: widget.paymentAmount,
        changeAmount: widget.changeAmount,
        items: formattedItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon with Animation
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 50,
                ),
              ),

              const SizedBox(height: 20),

              // Success Title
              Text(
                'Transaksi Berhasil!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Transaction Details
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Item:',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '${widget.totalQty} item',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Harga:',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            idrFormat(widget.totalPrice),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No. Transaksi:',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            widget.transactionResponse?.data?.orderNo != null
                                ? '#${widget.transactionResponse.data.orderNo}'
                                : '#${DateTime.now().millisecondsSinceEpoch % 100000}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    // Print Receipt Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _showReceiptPreview(context),
                        icon: const Icon(Icons.print, color: Colors.white),
                        label: const Text(
                          'Cetak Nota',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Home Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          widget.onHome?.call();
                        },
                        icon: Icon(Icons.home, color: AppColors.primary),
                        label: Text(
                          'Kembali ke Menu Utama',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Info text
                    Text(
                      'Pesanan berhasil dibuat dan menunggu pembayaran.\nSilakan ke tab Pembayaran untuk menyelesaikan transaksi.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

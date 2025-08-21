import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/payment_settlement/payment_settlement_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayWebView extends StatefulWidget {
  final String checkoutUrl;
  final int paymentId;

  const PaymentGatewayWebView({
    super.key,
    required this.checkoutUrl,
    required this.paymentId,
  });

  @override
  State<PaymentGatewayWebView> createState() => _PaymentGatewayWebViewState();
}

class _PaymentGatewayWebViewState extends State<PaymentGatewayWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isCancelled = false; // Flag to track if payment was cancelled

  @override
  void initState() {
    super.initState();
    _initializeWebView();
    // Polling is already started by PaymentSettlementBloc after payment settled
  }

  @override
  void dispose() {
    // Don't automatically stop polling on dispose
    // Polling should only stop on success, failure, or explicit cancellation
    super.dispose();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error loading payment page: ${error.description}',
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  void _showRetryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Text('Payment Failed'),
          ],
        ),
        content: const Text(
          'The payment has failed or expired. What would you like to do?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              _isCancelled = true; // Mark as cancelled
              context.read<PaymentSettlementBloc>().add(
                PaymentSettlementEvent.cancelPayment(
                  paymentId: widget.paymentId,
                ),
              );
            },
            child: const Text('Cancel Payment'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              context.read<PaymentSettlementBloc>().add(
                PaymentSettlementEvent.retryPayment(
                  paymentId: widget.paymentId,
                ),
              );
            },
            child: const Text('Retry Payment'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Show confirmation dialog before closing
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Cancel Payment'),
                content: const Text(
                  'Are you sure you want to cancel this payment?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      _isCancelled = true; // Mark as cancelled
                      context.read<PaymentSettlementBloc>().add(
                        PaymentSettlementEvent.cancelPayment(
                          paymentId: widget.paymentId,
                        ),
                      );
                      Navigator.of(context).pop(); // Close webview
                    },
                    child: const Text('Yes, Cancel'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: BlocListener<PaymentSettlementBloc, PaymentSettlementState>(
        listener: (context, state) {
          state.whenOrNull(
            paymentCompleted: (payment) {
              // Only close webview if not already cancelled
              if (!_isCancelled) {
                // Auto-close webview only, let parent page handle the success message
                Navigator.of(context).pop(); // Close webview immediately
                // Don't show snackbar here to avoid conflict with parent page
              }
            },
            paymentFailed: (payment, reason) {
              _showRetryDialog();
            },
            paymentExpired: (payment) {
              _showRetryDialog();
            },
            paymentRetried: (response) {
              // Reload webview with new checkout URL
              _controller.loadRequest(Uri.parse(response.checkoutUrl));
            },
            paymentCancelled: (response) {
              // Mark as cancelled to prevent success handler from running
              _isCancelled = true;
              // Auto-close webview immediately
              // Navigator.of(context).pop(); // Close webview
              // Let parent page handle the cancellation message
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $message'),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading payment page...'),
                  ],
                ),
              ),
            // Polling indicator
            BlocBuilder<PaymentSettlementBloc, PaymentSettlementState>(
              builder: (context, state) {
                return state.maybeWhen(
                  paymentPolling: (payment) => Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Checking payment...',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/animated_refresh_button.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/simple_filter_chips.dart';

class TransactionHeader extends StatelessWidget {
  const TransactionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Transaction History\n',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'List of transactions made by customers',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            const AnimatedRefreshButton(),
          ],
        ),
        const SizedBox(height: 16),
        const SimpleFilterChips(),
      ],
    );
  }
}

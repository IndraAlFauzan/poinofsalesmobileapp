import 'package:flutter/material.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/custom_app_bar.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/cart_items_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/transaction_details_widget.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Column(
          children: [
            const CustomAppBar(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [const Expanded(child: CartItemsWidget())],
                    ),
                  ),
                  const Expanded(flex: 2, child: TransactionDetailsWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

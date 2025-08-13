import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/payment_method/payment_method_bloc.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/bloc/add_transaction_bloc.dart';
import 'package:posmobile/data/model/request/transaction_model_request.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/product_cart_item.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/widgets/custom_alert_dialog.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  double? paymentAmount;
  double? changeAmount;
  int? selectedPaymentMethod;
  String? selectedServiceType;

  @override
  void initState() {
    super.initState();

    // Fetch payment methods saat halaman dimuat
    context.read<PaymentMethodBloc>().add(
      PaymentMethodEvent.fetchPaymentMethods(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Row(
          children: [
            //NavigationDrawers(),
            Expanded(flex: 6, child: _buildCartItems()),
            Expanded(flex: 2, child: _buildPaymentDetails()),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(context: context),
        const SizedBox(height: 16),
        Expanded(
          child: Stack(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(
                      child: Text("Tidak ada item dalam keranjang."),
                    ),
                    updated: (items, totalPrice, totalQty) {
                      if (items.isNotEmpty) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 kolom dalam grid
                                crossAxisSpacing: 8, // Jarak antar kolom
                                mainAxisSpacing: 8, // Jarak antar baris
                                childAspectRatio:
                                    1.5, // Menyesuaikan ukuran grid
                              ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProductCartItem(
                                item: items[index],
                                itemIndex: index,
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: Text("Tidak ada item dalam keranjang."),
                      );
                    },
                  );
                },
              ),
              Positioned(
                bottom: 16, // Jarak dari bawah
                right: 16, // Jarak dari kanan
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: const Text(
                    'Tambah Pesanan',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
              listener: (context, state) {
                state.when(
                  initial: () {},
                  loading: () {},
                  success: (paymentMethods) {},
                  failure: (message) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  },
                );
              },
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  failure: (message) => Center(child: Text("Error: $message")),
                  success: (paymentMethods) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        //Jumlah pesanan
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, cartState) {
                            return cartState.when(
                              initial: () => const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jumlah Pesanan: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "0 item",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              updated: (items, totalPrice, totalQty) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Jumlah Pesanan: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "$totalQty item",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Pilih Metode Pembayaran",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        CustomDropdown<String>(
                          hintText: "Metode Pembayaran",
                          decoration: CustomDropdownDecoration(
                            closedBorder: Border.all(color: Colors.grey),
                          ),
                          items: paymentMethods
                              .map((method) => method.name)
                              .toList(),
                          onChanged: (value) {
                            final selectedMethod = paymentMethods.firstWhere(
                              (method) => method.name == value,
                              orElse: () => paymentMethods.first,
                            );
                            setState(() {
                              selectedPaymentMethod = selectedMethod.id;
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CustomDropdown<String>(
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(color: Colors.grey),
                ),
                hintText: "Tipe Layanan",
                items: ["Dine In", "Take Away", "Delivery"],
                onChanged: (value) {
                  setState(() {
                    //inputnya Dine In jadi dine_in dan begitu seterusnya
                    final valueLower = value?.toLowerCase().replaceAll(
                      " ",
                      "_",
                    );
                    selectedServiceType = valueLower;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                return cartState.when(
                  initial: () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Total Harga",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        idrFormat(0),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  updated: (items, totalPrice, totalQty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Total Harga",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          idrFormat(totalPrice),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            selectedPaymentMethod == 1
                ? BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      return cartState.when(
                        initial: () => TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CurrencyTextInputFormatter.currency(
                              locale: 'id',
                              decimalDigits: 0,
                              symbol: 'Rp',
                            ),
                          ],
                          decoration: InputDecoration(
                            hintText: "Masukkan Uang Pelanggan",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              String cleanedValue = value.replaceAll(
                                RegExp(r'[^0-9]'),
                                '',
                              );
                              paymentAmount =
                                  double.tryParse(cleanedValue) ?? 0;
                              changeAmount =
                                  paymentAmount! -
                                  0; // totalPrice = 0 untuk initial
                            });
                          },
                        ),
                        updated: (items, totalPrice, totalQty) {
                          return TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              CurrencyTextInputFormatter.currency(
                                locale: 'id',
                                decimalDigits: 0,
                                symbol: 'Rp',
                              ),
                            ],
                            decoration: InputDecoration(
                              hintText: "Masukkan Uang Pelanggan",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                String cleanedValue = value.replaceAll(
                                  RegExp(r'[^0-9]'),
                                  '',
                                );
                                paymentAmount =
                                    double.tryParse(cleanedValue) ?? 0;
                                changeAmount = paymentAmount! - totalPrice;
                              });
                            },
                          );
                        },
                      );
                    },
                  )
                : const SizedBox(),
            const SizedBox(height: 16),
            selectedPaymentMethod == 1
                ? BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      return cartState.when(
                        initial: () => const SizedBox(),
                        updated: (items, totalPrice, totalQty) {
                          return Text(
                            "Kembalian: ${idrFormat(changeAmount ?? 0)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      );
                    },
                  )
                : const SizedBox(),
            // const SizedBox(
            //   width: double.infinity,
            //   child: Text(
            //     "Kembalian",
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
            // const SizedBox(height: 8),
            // Text(
            //   idrFormat(changeAmount ?? 0),
            //   style: TextStyle(
            //     color: (changeAmount ?? 0) < 0
            //         ? Colors.red
            //         : Colors.black, // Merah jika kurang
            //     fontWeight: FontWeight.bold,
            //     fontSize: 18,
            //   ),
            // ),
            const SizedBox(height: 16),
            BlocConsumer<AddTransactionBloc, AddTransactionState>(
              listener: (context, state) {
                state.when(
                  initial: () {},
                  loading: () {},
                  success: (response) {
                    // Tampilkan notifikasi sukses
                    Flushbar(
                      title: "Sukses",
                      message: "Transaksi berhasil ditambahkan",
                      duration: const Duration(seconds: 4),
                      flushbarStyle: FlushbarStyle.FLOATING,
                      flushbarPosition: FlushbarPosition.TOP,
                      textDirection: Directionality.of(context),
                      borderRadius: BorderRadius.circular(12),
                      leftBarIndicatorColor: Colors.blue[300],
                    ).show(context);

                    // **Pastikan widget masih aktif sebelum mengubah state**
                    if (mounted) {
                      setState(() {
                        paymentAmount = null;
                        changeAmount = null;
                        selectedPaymentMethod = null;
                        selectedServiceType = null;
                      });

                      // **Pastikan widget masih aktif sebelum memanggil BLoC**
                      context.read<CartBloc>().add(const CartEvent.clearCart());
                    }

                    // **Tampilkan dialog setelah reset**
                    Future.delayed(Duration.zero, () {
                      if (mounted) {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                              title: 'Berhasil',
                              content: 'Apakah Anda yakin ingin print?',
                              cancelText: 'Home',
                              confirmText: 'Print',
                              onCancel: () {
                                if (mounted) {
                                  //push remove until
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/main',
                                    (route) => false,
                                  );
                                }
                              },
                              onConfirm: () {
                                // PrinterService.printReceipt(response);
                              },
                            );
                          },
                        );
                      }
                    });
                  },
                  failure: (message) {
                    if (mounted) {
                      Flushbar(
                        title: "Gagal",
                        message: message,
                        duration: const Duration(seconds: 3),
                        flushbarStyle: FlushbarStyle.FLOATING,
                        flushbarPosition: FlushbarPosition.TOP,
                        textDirection: Directionality.of(context),
                        borderRadius: BorderRadius.circular(12),
                        leftBarIndicatorColor: Colors.red[300],
                      ).show(context);
                    }
                  },
                );
              },
              builder: (context, state) {
                return state.when(
                  initial: () => _buildPaymentButton(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  success: (_) => _buildPaymentButton(),
                  failure: (_) => _buildPaymentButton(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton() {
    return ElevatedButton(
      onPressed: () {
        if (selectedPaymentMethod == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Pilih metode pembayaran")),
          );
          return;
        }

        if (selectedServiceType == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Pilih tipe layanan")));
          return;
        }

        if (selectedPaymentMethod == 1 &&
            (paymentAmount == null || paymentAmount! < 1)) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Masukkan jumlah uang")));
          return;
        }

        final cartState = context.read<CartBloc>().state;

        cartState.when(
          initial: () {},
          updated: (items, totalPrice, totalQty) {
            // Ambil user ID dari LoginBloc response
            final loginState = context.read<LoginBloc>().state;
            final userId = loginState.maybeWhen(
              success: (loginResponse) => loginResponse.data.userId,
              orElse: () => 1, // Default userId jika tidak ada login state
            );

            final transaction = TransactionModelRequest(
              userId: userId,
              paymentMethodId: selectedPaymentMethod!,
              paymentAmount: selectedPaymentMethod == 1
                  ? paymentAmount!.toInt()
                  : totalPrice.toInt(),
              serviceType: selectedServiceType!,
              details: items
                  .map(
                    (item) => Detail(
                      productId: item.product.id,
                      quantity: item.quantity,
                      note: item.note ?? "",
                      flavorId: item.selectedFlavor?.id,
                      spicyLevelId: item.selectedSpicyLevel?.id,
                    ),
                  )
                  .toList(),
            );

            context.read<AddTransactionBloc>().add(
              AddTransactionEvent.addTransaction(req: transaction),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.blue,
      ),
      child: const Text(
        "Bayar Sekarang",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Text(
            "Detail Pesanan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          // User info dan waktu seperti di TopBar
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final name = state.maybeWhen(
                success: (res) => res.data.user,
                orElse: () => 'Pengguna',
              );
              return Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Hallo, ${name.isNotEmpty ? name : 'Pengguna'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  StreamBuilder<DateTime>(
                    stream: Stream.periodic(
                      const Duration(seconds: 1),
                      (_) => DateTime.now(),
                    ),
                    initialData: DateTime.now(),
                    builder: (context, snapshot) {
                      final now = snapshot.data ?? DateTime.now();
                      return Text(
                        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

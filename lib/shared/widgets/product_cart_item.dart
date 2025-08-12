import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/flavor/flavor_bloc.dart';
import 'package:posmobile/data/model/response/cart_item_model.dart';
import 'package:posmobile/data/model/response/flavor_model_response.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';

class ProductCartItem extends StatefulWidget {
  final CartItemModel item;
  final int itemIndex; // Tambahkan index

  const ProductCartItem({
    super.key,
    required this.item,
    required this.itemIndex, // Tambahkan parameter index
  });

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  late TextEditingController _noteController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.item.note ?? '');
    _quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProductCartItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update quantity controller when widget updates (e.g., from external changes)
    if (oldWidget.item.quantity != widget.item.quantity) {
      _quantityController.text = widget.item.quantity.toString();
    }
    // Update note controller when widget updates
    if (oldWidget.item.note != widget.item.note) {
      _noteController.text = widget.item.note ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product info and remove button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.item.product.photoUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),

              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      idrFormat(widget.item.product.price),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // Remove button
              GestureDetector(
                onTap: () {
                  context.read<CartBloc>().add(
                    CartEvent.removeFromCart(
                      product: widget.item.product,
                      selectedFlavor: widget.item.selectedFlavor,
                      selectedSpicyLevel: widget.item.selectedSpicyLevel,
                      note: widget.item.note,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red.shade400,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          // Flavor and Spicy Level dropdowns - hanya untuk kategori selain Minuman dan Topping
          if (widget.item.product.category != 'Minuman' &&
              widget.item.product.category != 'Topping')
            Row(
              children: [
                // Flavor dropdown
                Expanded(
                  child: BlocBuilder<FlavorBloc, FlavorState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink(),
                        failure: (msg) => const SizedBox.shrink(),
                        success: (flavors) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rasa:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Flavor>(
                                    isExpanded: true,
                                    value: widget.item.selectedFlavor,
                                    hint: const Text(
                                      'Pilih Rasa',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    items: flavors.map((flavor) {
                                      return DropdownMenuItem<Flavor>(
                                        value: flavor,
                                        child: Text(flavor.name),
                                      );
                                    }).toList(),
                                    onChanged: (Flavor? newFlavor) {
                                      if (newFlavor != null) {
                                        context.read<CartBloc>().add(
                                          CartEvent.updateFlavorByIndex(
                                            itemIndex: widget.itemIndex,
                                            flavor: newFlavor,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // Todo: Spicy Level dropdown placeholder
                // Spicy Level dropdown - hanya untuk kategori selain Minuman dan Topping
                Expanded(
                  child: BlocBuilder<FlavorBloc, FlavorState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink(),
                        failure: (msg) => const SizedBox.shrink(),
                        success: (flavors) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rasa:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Flavor>(
                                    isExpanded: true,
                                    value: widget.item.selectedFlavor,
                                    hint: const Text(
                                      'Pilih Rasa',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    items: flavors.map((flavor) {
                                      return DropdownMenuItem<Flavor>(
                                        value: flavor,
                                        child: Text(flavor.name),
                                      );
                                    }).toList(),
                                    onChanged: (Flavor? newFlavor) {
                                      if (newFlavor != null) {
                                        context.read<CartBloc>().add(
                                          CartEvent.updateFlavorByIndex(
                                            itemIndex: widget.itemIndex,
                                            flavor: newFlavor,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Catatan:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _noteController,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Tambahkan catatan...',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                maxLines: 2,
                onChanged: (note) {
                  context.read<CartBloc>().add(
                    CartEvent.updateNoteByIndex(
                      itemIndex: widget.itemIndex,
                      note: note,
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Quantity controls and total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quantity controls
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final newQty = widget.item.quantity - 1;
                      if (newQty >= 1) {
                        _quantityController.text = newQty.toString();
                        context.read<CartBloc>().add(
                          CartEvent.updateQuantityByIndex(
                            itemIndex: widget.itemIndex,
                            quantity: newQty,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Quantity input field
                  Container(
                    width: 50,
                    height: 28,
                    child: TextField(
                      controller: _quantityController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(4),
                      ),
                      onChanged: (value) {
                        final newQty = int.tryParse(value) ?? 1;
                        if (newQty >= 1 && newQty <= 99) {
                          context.read<CartBloc>().add(
                            CartEvent.updateQuantityByIndex(
                              itemIndex: widget.itemIndex,
                              quantity: newQty,
                            ),
                          );
                        }
                      },
                      onSubmitted: (value) {
                        final newQty = int.tryParse(value) ?? 1;
                        final validQty = newQty < 1
                            ? 1
                            : (newQty > 99 ? 99 : newQty);
                        _quantityController.text = validQty.toString();
                        context.read<CartBloc>().add(
                          CartEvent.updateQuantityByIndex(
                            itemIndex: widget.itemIndex,
                            quantity: validQty,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      final newQty = widget.item.quantity + 1;
                      if (newQty <= 99) {
                        _quantityController.text = newQty.toString();
                        context.read<CartBloc>().add(
                          CartEvent.updateQuantityByIndex(
                            itemIndex: widget.itemIndex,
                            quantity: newQty,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Total price for this item
              Text(
                idrFormat(widget.item.product.price * widget.item.quantity),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

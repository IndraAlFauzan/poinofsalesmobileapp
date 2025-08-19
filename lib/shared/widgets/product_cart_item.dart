import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/flavor/flavor_bloc.dart';
import 'package:posmobile/bloc/spicylevel/spicy_level_bloc.dart';
import 'package:posmobile/data/model/response/cart_item_model.dart';
import 'package:posmobile/data/model/response/flavor_model_response.dart';
import 'package:posmobile/data/model/response/spicy_level_model_response.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/mixins/responsive_mixin.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

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

class _ProductCartItemState extends State<ProductCartItem>
    with ResponsiveMixin {
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
      margin: EdgeInsets.only(bottom: context.spacing.sm),
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(context.radius.md),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product info and remove button
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildProductImage(),
                ),
                const SizedBox(width: 12),

                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                      priceText(
                        idrFormat(widget.item.product.price),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        context: context,
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
                      color: context.colorScheme.errorContainer.withValues(
                        alpha: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(context.radius.sm),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: context.colorScheme.error,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          // Flavor and Spicy Level dropdowns - hanya untuk kategori selain Minuman dan Topping
          if (widget.item.product.category != 'Minuman' &&
              widget.item.product.category != 'Toping')
            Flexible(
              child: Row(
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
                                Text(
                                  'Rasa:',
                                  style: context.textTheme.labelSmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(height: context.spacing.xs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.spacing.sm,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.colorScheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      context.radius.sm,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Flavor>(
                                      isExpanded: true,
                                      value: widget.item.selectedFlavor,
                                      hint: Text(
                                        'Pilih Rasa',
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                              fontSize: 12,
                                              color: context
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                      ),
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            fontSize: 12,
                                            color:
                                                context.colorScheme.onSurface,
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
                  // Spicy Level dropdown
                  Expanded(
                    child: BlocBuilder<SpicyLevelBloc, SpicyLevelState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => const SizedBox.shrink(),
                          failure: (msg) => const SizedBox.shrink(),
                          success: (level) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Level:',
                                  style: context.textTheme.labelSmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(height: context.spacing.xs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.spacing.sm,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.colorScheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      context.radius.sm,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<SpicyLevel>(
                                      isExpanded: true,
                                      value: widget.item.selectedSpicyLevel,
                                      hint: Text(
                                        'Pilih Level',
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                              fontSize: 12,
                                              color: context
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                      ),
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            fontSize: 12,
                                            color:
                                                context.colorScheme.onSurface,
                                          ),
                                      items: level.map((level) {
                                        return DropdownMenuItem<SpicyLevel>(
                                          value: level,
                                          child: Text(level.name),
                                        );
                                      }).toList(),
                                      onChanged: (SpicyLevel? newLevel) {
                                        if (newLevel != null) {
                                          context.read<CartBloc>().add(
                                            CartEvent.updateSpicyLevelByIndex(
                                              itemIndex: widget.itemIndex,
                                              spicyLevel: newLevel,
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
            ),
          SizedBox(height: context.spacing.lg),
          // Kalau Toping
          if (widget.item.product.category != 'Toping')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catatan:',
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.spacing.xs),
                TextField(
                  controller: _noteController,
                  style: context.textTheme.bodySmall?.copyWith(fontSize: 12),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Tambahkan catatan...',
                    hintStyle: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(context.radius.sm),
                      borderSide: BorderSide(
                        color: context.colorScheme.outline,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(context.radius.sm),
                      borderSide: BorderSide(
                        color: context.colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(context.radius.sm),
                      borderSide: BorderSide(
                        color: context.colorScheme.primary,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.spacing.sm,
                      vertical: context.spacing.xs,
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

                    // style on tap
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: context.colorScheme.error.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(context.radius.sm),
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 16,
                        color: context.colorScheme.surface,
                      ),
                    ),
                  ),
                  SizedBox(width: context.spacing.sm),
                  // Quantity input field
                  SizedBox(
                    width: 50,
                    height: 28,
                    child: TextField(
                      controller: _quantityController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.sm,
                          ),
                          borderSide: BorderSide(
                            color: context.colorScheme.outline,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.sm,
                          ),
                          borderSide: BorderSide(
                            color: context.colorScheme.outline,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.sm,
                          ),
                          borderSide: BorderSide(
                            color: context.colorScheme.primary,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(context.spacing.xs),
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
                  SizedBox(width: context.spacing.sm),
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
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(context.radius.sm),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),

              // Total price for this item
              priceText(
                idrFormat(widget.item.product.price * widget.item.quantity),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    // Handle null or empty photoUrl
    if (widget.item.product.photoUrl == null ||
        widget.item.product.photoUrl!.trim().isEmpty) {
      return _buildPlaceholderImage();
    }

    return Image.network(
      widget.item.product.photoUrl!,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.radius.sm),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            size: 20,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 2),
          Text(
            'No Image',
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 8,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

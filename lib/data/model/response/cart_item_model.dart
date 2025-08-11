import 'package:posmobile/data/model/response/flavor_model_response.dart';
import 'package:posmobile/data/model/response/product_model_response.dart';
import 'package:posmobile/data/model/response/spicy_level_model_response.dart';

class CartItemModel {
  final Product product;
  final int quantity;
  final String? note;
  final Flavor? selectedFlavor;
  final SpicyLevel? selectedSpicyLevel;

  const CartItemModel({
    required this.product,
    this.quantity = 1,
    this.note,
    this.selectedFlavor,
    this.selectedSpicyLevel,
  });

  CartItemModel copyWith({
    Product? product,
    int? quantity,
    String? note,
    Flavor? selectedFlavor,
    SpicyLevel? selectedSpicyLevel,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
      selectedFlavor: selectedFlavor ?? this.selectedFlavor,
      selectedSpicyLevel: selectedSpicyLevel ?? this.selectedSpicyLevel,
    );
  }
}

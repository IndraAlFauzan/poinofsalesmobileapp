part of 'cart_bloc.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;

  const factory CartState.updated({
    required List<CartItemModel> items,
    required double totalPrice,
    required int totalQty,
  }) = _Updated;
}

part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.addToCart({
    required Product product,
    Flavor? selectedFlavor,

    SpicyLevel? selectedSpicyLevel,
    String? note,
  }) = _AddToCart;

  const factory CartEvent.removeFromCart({
    required Product product,
    Flavor? selectedFlavor,
    SpicyLevel? selectedSpicyLevel,
    String? note,
  }) = _RemoveFromCart;

  const factory CartEvent.updateQuantity({
    required Product product,
    required int quantity,
    Flavor? selectedFlavor,
    SpicyLevel? selectedSpicyLevel,
    String? note,
  }) = _UpdateQuantity;

  const factory CartEvent.updateNote({
    required Product product,
    required String note,
    Flavor? selectedFlavor,
    SpicyLevel? selectedSpicyLevel,
  }) = _UpdateNote;

  const factory CartEvent.updateFlavor({
    required Product product,
    required Flavor flavor,
    SpicyLevel? selectedSpicyLevel,
    String? note,
  }) = _UpdateFlavor;

  const factory CartEvent.updateSpicyLevel({
    required Product product,
    required SpicyLevel spicyLevel,
    Flavor? selectedFlavor,
    String? note,
  }) = _UpdateSpicyLevel;

  const factory CartEvent.updateFlavorByIndex({
    required int itemIndex,
    required Flavor flavor,
  }) = _UpdateFlavorByIndex;

  const factory CartEvent.updateSpicyLevelByIndex({
    required int itemIndex,
    required SpicyLevel spicyLevel,
  }) = _UpdateSpicyLevelByIndex;

  const factory CartEvent.updateNoteByIndex({
    required int itemIndex,
    required String note,
  }) = _UpdateNoteByIndex;

  const factory CartEvent.updateQuantityByIndex({
    required int itemIndex,
    required int quantity,
  }) = _UpdateQuantityByIndex;

  const factory CartEvent.removeByIndex({required int itemIndex}) =
      _RemoveByIndex;

  const factory CartEvent.clearCart() = _ClearCart;
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/cart_item_model.dart';
import 'package:posmobile/data/model/response/flavor_model_response.dart';
import 'package:posmobile/data/model/response/product_model_response.dart';
import 'package:posmobile/data/model/response/spicy_level_model_response.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItemModel> _items = const [];

  CartBloc() : super(const CartState.initial()) {
    on<_AddToCart>(_onAddToCart);
    on<_RemoveFromCart>(_onRemoveFromCart);
    on<_UpdateQuantity>(_onUpdateQuantity);
    on<_UpdateNote>(_onUpdateNote);
    on<_UpdateFlavor>(_onUpdateFlavor);
    on<_UpdateSpicyLevel>(_onUpdateSpicyLevel);
    on<_UpdateFlavorByIndex>(_onUpdateFlavorByIndex);
    on<_UpdateSpicyLevelByIndex>(_onUpdateSpicyLevelByIndex);
    on<_UpdateNoteByIndex>(_onUpdateNoteByIndex);
    on<_UpdateQuantityByIndex>(_onUpdateQuantityByIndex);
    on<_RemoveByIndex>(_onRemoveByIndex);
    on<_ClearCart>(_onClearCart);
  }

  double _totalPrice(List<CartItemModel> list) {
    return list.fold(0, (sum, i) => sum + (i.product.price * i.quantity));
  }

  void _emitUpdated(Emitter<CartState> emit) {
    emit(
      CartState.updated(
        items: List.unmodifiable(_items),
        totalPrice: _totalPrice(_items),
        totalQty: _items.fold(0, (sum, i) => sum + i.quantity),
      ),
    );
  }

  void _onAddToCart(_AddToCart e, Emitter<CartState> emit) {
    final idx = _findIndex(
      e.product,
      e.selectedFlavor,
      e.selectedSpicyLevel,
      e.note,
    );
    if (idx >= 0) {
      _items = [
        ..._items.take(idx),
        _items[idx].copyWith(quantity: _items[idx].quantity + 1),
        ..._items.skip(idx + 1),
      ];
    } else {
      _items = [
        ..._items,
        CartItemModel(
          product: e.product,
          selectedFlavor: e.selectedFlavor,
          selectedSpicyLevel: e.selectedSpicyLevel,
          note: e.note?.trim(),
        ),
      ];
    }
    _emitUpdated(emit);
  }

  void _onRemoveFromCart(_RemoveFromCart e, Emitter<CartState> emit) {
    final idx = _findIndex(
      e.product,
      e.selectedFlavor,
      e.selectedSpicyLevel,
      e.note,
    );
    if (idx >= 0) {
      _items = [..._items]..removeAt(idx);
      _emitUpdated(emit);
    }
  }

  void _onUpdateQuantity(_UpdateQuantity e, Emitter<CartState> emit) {
    final idx = _findIndex(
      e.product,
      e.selectedFlavor,
      e.selectedSpicyLevel,
      e.note,
    );
    if (idx >= 0) {
      if (e.quantity <= 0) {
        _items = [..._items]..removeAt(idx);
      } else {
        _items = [
          ..._items.take(idx),
          _items[idx].copyWith(quantity: e.quantity),
          ..._items.skip(idx + 1),
        ];
      }
      _emitUpdated(emit);
    }
  }

  void _onUpdateNote(_UpdateNote e, Emitter<CartState> emit) {
    final oldIdx = _findIndexIgnoringNote(
      e.product,
      e.selectedFlavor,
      e.selectedSpicyLevel,
    );
    if (oldIdx < 0) return;

    final oldLine = _items[oldIdx];
    final newNote = e.note.trim();

    // Key lama & baru
    final newIdx = _findIndex(
      e.product,
      e.selectedFlavor,
      e.selectedSpicyLevel,
      newNote,
    );

    List<CartItemModel> next = [..._items];
    if (newIdx >= 0 && newIdx != oldIdx) {
      // sudah ada line dengan kombinasi baru → gabung qty
      final merged = next[newIdx].copyWith(
        quantity: next[newIdx].quantity + oldLine.quantity,
      );
      // hapus old lalu set merged (hati2 index geser)
      next.removeAt(oldIdx);
      final adjustedNewIdx = newIdx > oldIdx ? newIdx - 1 : newIdx;
      next[adjustedNewIdx] = merged;
    } else {
      // pindahkan note di line lama
      next[oldIdx] = oldLine.copyWith(note: newNote);
    }

    _items = next;
    _emitUpdated(emit);
  }

  void _onUpdateFlavor(_UpdateFlavor e, Emitter<CartState> emit) {
    // cari baris lama berdasarkan product, spicy level, dan note (mengabaikan flavor)
    final oldIdx = _findIndexIgnoringFlavor(
      e.product,
      e.selectedSpicyLevel,
      e.note,
    );
    if (oldIdx < 0) return;

    final oldLine = _items[oldIdx];
    final newIdx = _findIndex(
      e.product,
      e.flavor,
      e.selectedSpicyLevel,
      e.note,
    );

    List<CartItemModel> next = [..._items];
    if (newIdx >= 0 && newIdx != oldIdx) {
      // sudah ada line tujuan → gabung qty
      final merged = next[newIdx].copyWith(
        quantity: next[newIdx].quantity + oldLine.quantity,
      );
      next.removeAt(oldIdx);
      final adjustedNewIdx = newIdx > oldIdx ? newIdx - 1 : newIdx;
      next[adjustedNewIdx] = merged;
    } else {
      next[oldIdx] = oldLine.copyWith(selectedFlavor: e.flavor);
    }

    _items = next;
    _emitUpdated(emit);
  }

  void _onUpdateSpicyLevel(_UpdateSpicyLevel e, Emitter<CartState> emit) {
    // cari baris lama berdasarkan product, flavor, dan note (mengabaikan spicy level)
    final oldIdx = _findIndexIgnoringSpicyLevel(
      e.product,
      e.selectedFlavor,
      e.note,
    );
    if (oldIdx < 0) return;

    final oldLine = _items[oldIdx];
    final newIdx = _findIndex(
      e.product,
      e.selectedFlavor,
      e.spicyLevel,
      e.note,
    );

    List<CartItemModel> next = [..._items];
    if (newIdx >= 0 && newIdx != oldIdx) {
      final merged = next[newIdx].copyWith(
        quantity: next[newIdx].quantity + oldLine.quantity,
      );
      next.removeAt(oldIdx);
      final adjustedNewIdx = newIdx > oldIdx ? newIdx - 1 : newIdx;
      next[adjustedNewIdx] = merged;
    } else {
      next[oldIdx] = oldLine.copyWith(selectedSpicyLevel: e.spicyLevel);
    }

    _items = next;
    _emitUpdated(emit);
  }

  void _onClearCart(_ClearCart e, Emitter<CartState> emit) {
    _items = [];
    _emitUpdated(emit);
  }

  int _findIndex(Product p, Flavor? f, SpicyLevel? s, String? note) {
    final n = note?.trim();
    return _items.indexWhere(
      (item) =>
          item.product.id == p.id &&
          item.selectedFlavor?.id == f?.id &&
          item.selectedSpicyLevel?.id == s?.id &&
          (item.note?.trim() ?? '') == (n ?? ''),
    );
  }

  int _findIndexIgnoringNote(
    Product product,
    Flavor? flavor,
    SpicyLevel? spicy,
  ) {
    return _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedFlavor?.id == flavor?.id &&
          item.selectedSpicyLevel?.id == spicy?.id,
    );
  }

  int _findIndexIgnoringFlavor(
    Product product,
    SpicyLevel? spicy,
    String? note,
  ) {
    final n = note?.trim();
    return _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSpicyLevel?.id == spicy?.id &&
          (item.note?.trim() ?? '') == (n ?? ''),
    );
  }

  int _findIndexIgnoringSpicyLevel(
    Product product,
    Flavor? flavor,
    String? note,
  ) {
    final n = note?.trim();
    return _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedFlavor?.id == flavor?.id &&
          (item.note?.trim() ?? '') == (n ?? ''),
    );
  }

  // Index-based handlers untuk menghindari bug identity
  void _onUpdateFlavorByIndex(_UpdateFlavorByIndex e, Emitter<CartState> emit) {
    if (e.itemIndex < 0 || e.itemIndex >= _items.length) return;

    final item = _items[e.itemIndex];
    final updatedItem = item.copyWith(selectedFlavor: e.flavor);

    _items = [
      ..._items.take(e.itemIndex),
      updatedItem,
      ..._items.skip(e.itemIndex + 1),
    ];
    _emitUpdated(emit);
  }

  void _onUpdateSpicyLevelByIndex(
    _UpdateSpicyLevelByIndex e,
    Emitter<CartState> emit,
  ) {
    if (e.itemIndex < 0 || e.itemIndex >= _items.length) return;

    final item = _items[e.itemIndex];
    final updatedItem = item.copyWith(selectedSpicyLevel: e.spicyLevel);

    _items = [
      ..._items.take(e.itemIndex),
      updatedItem,
      ..._items.skip(e.itemIndex + 1),
    ];
    _emitUpdated(emit);
  }

  void _onUpdateNoteByIndex(_UpdateNoteByIndex e, Emitter<CartState> emit) {
    if (e.itemIndex < 0 || e.itemIndex >= _items.length) return;

    final item = _items[e.itemIndex];
    final updatedItem = item.copyWith(note: e.note.trim());

    _items = [
      ..._items.take(e.itemIndex),
      updatedItem,
      ..._items.skip(e.itemIndex + 1),
    ];
    _emitUpdated(emit);
  }

  void _onUpdateQuantityByIndex(
    _UpdateQuantityByIndex e,
    Emitter<CartState> emit,
  ) {
    if (e.itemIndex < 0 || e.itemIndex >= _items.length) return;

    if (e.quantity <= 0) {
      _items = [..._items]..removeAt(e.itemIndex);
    } else {
      final item = _items[e.itemIndex];
      final updatedItem = item.copyWith(quantity: e.quantity);

      _items = [
        ..._items.take(e.itemIndex),
        updatedItem,
        ..._items.skip(e.itemIndex + 1),
      ];
    }
    _emitUpdated(emit);
  }

  void _onRemoveByIndex(_RemoveByIndex e, Emitter<CartState> emit) {
    if (e.itemIndex < 0 || e.itemIndex >= _items.length) return;

    _items = [..._items]..removeAt(e.itemIndex);
    _emitUpdated(emit);
  }
}

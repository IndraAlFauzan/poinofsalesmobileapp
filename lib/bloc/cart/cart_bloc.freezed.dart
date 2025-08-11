// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent()';
}


}

/// @nodoc
class $CartEventCopyWith<$Res>  {
$CartEventCopyWith(CartEvent _, $Res Function(CartEvent) __);
}


/// Adds pattern-matching-related methods to [CartEvent].
extension CartEventPatterns on CartEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AddToCart value)?  addToCart,TResult Function( _RemoveFromCart value)?  removeFromCart,TResult Function( _UpdateQuantity value)?  updateQuantity,TResult Function( _UpdateNote value)?  updateNote,TResult Function( _UpdateFlavor value)?  updateFlavor,TResult Function( _UpdateSpicyLevel value)?  updateSpicyLevel,TResult Function( _UpdateFlavorByIndex value)?  updateFlavorByIndex,TResult Function( _UpdateSpicyLevelByIndex value)?  updateSpicyLevelByIndex,TResult Function( _UpdateNoteByIndex value)?  updateNoteByIndex,TResult Function( _UpdateQuantityByIndex value)?  updateQuantityByIndex,TResult Function( _RemoveByIndex value)?  removeByIndex,TResult Function( _ClearCart value)?  clearCart,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddToCart() when addToCart != null:
return addToCart(_that);case _RemoveFromCart() when removeFromCart != null:
return removeFromCart(_that);case _UpdateQuantity() when updateQuantity != null:
return updateQuantity(_that);case _UpdateNote() when updateNote != null:
return updateNote(_that);case _UpdateFlavor() when updateFlavor != null:
return updateFlavor(_that);case _UpdateSpicyLevel() when updateSpicyLevel != null:
return updateSpicyLevel(_that);case _UpdateFlavorByIndex() when updateFlavorByIndex != null:
return updateFlavorByIndex(_that);case _UpdateSpicyLevelByIndex() when updateSpicyLevelByIndex != null:
return updateSpicyLevelByIndex(_that);case _UpdateNoteByIndex() when updateNoteByIndex != null:
return updateNoteByIndex(_that);case _UpdateQuantityByIndex() when updateQuantityByIndex != null:
return updateQuantityByIndex(_that);case _RemoveByIndex() when removeByIndex != null:
return removeByIndex(_that);case _ClearCart() when clearCart != null:
return clearCart(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AddToCart value)  addToCart,required TResult Function( _RemoveFromCart value)  removeFromCart,required TResult Function( _UpdateQuantity value)  updateQuantity,required TResult Function( _UpdateNote value)  updateNote,required TResult Function( _UpdateFlavor value)  updateFlavor,required TResult Function( _UpdateSpicyLevel value)  updateSpicyLevel,required TResult Function( _UpdateFlavorByIndex value)  updateFlavorByIndex,required TResult Function( _UpdateSpicyLevelByIndex value)  updateSpicyLevelByIndex,required TResult Function( _UpdateNoteByIndex value)  updateNoteByIndex,required TResult Function( _UpdateQuantityByIndex value)  updateQuantityByIndex,required TResult Function( _RemoveByIndex value)  removeByIndex,required TResult Function( _ClearCart value)  clearCart,}){
final _that = this;
switch (_that) {
case _AddToCart():
return addToCart(_that);case _RemoveFromCart():
return removeFromCart(_that);case _UpdateQuantity():
return updateQuantity(_that);case _UpdateNote():
return updateNote(_that);case _UpdateFlavor():
return updateFlavor(_that);case _UpdateSpicyLevel():
return updateSpicyLevel(_that);case _UpdateFlavorByIndex():
return updateFlavorByIndex(_that);case _UpdateSpicyLevelByIndex():
return updateSpicyLevelByIndex(_that);case _UpdateNoteByIndex():
return updateNoteByIndex(_that);case _UpdateQuantityByIndex():
return updateQuantityByIndex(_that);case _RemoveByIndex():
return removeByIndex(_that);case _ClearCart():
return clearCart(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AddToCart value)?  addToCart,TResult? Function( _RemoveFromCart value)?  removeFromCart,TResult? Function( _UpdateQuantity value)?  updateQuantity,TResult? Function( _UpdateNote value)?  updateNote,TResult? Function( _UpdateFlavor value)?  updateFlavor,TResult? Function( _UpdateSpicyLevel value)?  updateSpicyLevel,TResult? Function( _UpdateFlavorByIndex value)?  updateFlavorByIndex,TResult? Function( _UpdateSpicyLevelByIndex value)?  updateSpicyLevelByIndex,TResult? Function( _UpdateNoteByIndex value)?  updateNoteByIndex,TResult? Function( _UpdateQuantityByIndex value)?  updateQuantityByIndex,TResult? Function( _RemoveByIndex value)?  removeByIndex,TResult? Function( _ClearCart value)?  clearCart,}){
final _that = this;
switch (_that) {
case _AddToCart() when addToCart != null:
return addToCart(_that);case _RemoveFromCart() when removeFromCart != null:
return removeFromCart(_that);case _UpdateQuantity() when updateQuantity != null:
return updateQuantity(_that);case _UpdateNote() when updateNote != null:
return updateNote(_that);case _UpdateFlavor() when updateFlavor != null:
return updateFlavor(_that);case _UpdateSpicyLevel() when updateSpicyLevel != null:
return updateSpicyLevel(_that);case _UpdateFlavorByIndex() when updateFlavorByIndex != null:
return updateFlavorByIndex(_that);case _UpdateSpicyLevelByIndex() when updateSpicyLevelByIndex != null:
return updateSpicyLevelByIndex(_that);case _UpdateNoteByIndex() when updateNoteByIndex != null:
return updateNoteByIndex(_that);case _UpdateQuantityByIndex() when updateQuantityByIndex != null:
return updateQuantityByIndex(_that);case _RemoveByIndex() when removeByIndex != null:
return removeByIndex(_that);case _ClearCart() when clearCart != null:
return clearCart(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Product product,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)?  addToCart,TResult Function( Product product,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)?  removeFromCart,TResult Function( Product product,  int quantity,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)?  updateQuantity,TResult Function( Product product,  String note,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel)?  updateNote,TResult Function( Product product,  Flavor flavor,  SpicyLevel? selectedSpicyLevel,  String? note)?  updateFlavor,TResult Function( Product product,  SpicyLevel spicyLevel,  Flavor? selectedFlavor,  String? note)?  updateSpicyLevel,TResult Function( int itemIndex,  Flavor flavor)?  updateFlavorByIndex,TResult Function( int itemIndex,  SpicyLevel spicyLevel)?  updateSpicyLevelByIndex,TResult Function( int itemIndex,  String note)?  updateNoteByIndex,TResult Function( int itemIndex,  int quantity)?  updateQuantityByIndex,TResult Function( int itemIndex)?  removeByIndex,TResult Function()?  clearCart,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddToCart() when addToCart != null:
return addToCart(_that.product,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _RemoveFromCart() when removeFromCart != null:
return removeFromCart(_that.product,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _UpdateQuantity() when updateQuantity != null:
return updateQuantity(_that.product,_that.quantity,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _UpdateNote() when updateNote != null:
return updateNote(_that.product,_that.note,_that.selectedFlavor,_that.selectedSpicyLevel);case _UpdateFlavor() when updateFlavor != null:
return updateFlavor(_that.product,_that.flavor,_that.selectedSpicyLevel,_that.note);case _UpdateSpicyLevel() when updateSpicyLevel != null:
return updateSpicyLevel(_that.product,_that.spicyLevel,_that.selectedFlavor,_that.note);case _UpdateFlavorByIndex() when updateFlavorByIndex != null:
return updateFlavorByIndex(_that.itemIndex,_that.flavor);case _UpdateSpicyLevelByIndex() when updateSpicyLevelByIndex != null:
return updateSpicyLevelByIndex(_that.itemIndex,_that.spicyLevel);case _UpdateNoteByIndex() when updateNoteByIndex != null:
return updateNoteByIndex(_that.itemIndex,_that.note);case _UpdateQuantityByIndex() when updateQuantityByIndex != null:
return updateQuantityByIndex(_that.itemIndex,_that.quantity);case _RemoveByIndex() when removeByIndex != null:
return removeByIndex(_that.itemIndex);case _ClearCart() when clearCart != null:
return clearCart();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Product product,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)  addToCart,required TResult Function( Product product,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)  removeFromCart,required TResult Function( Product product,  int quantity,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)  updateQuantity,required TResult Function( Product product,  String note,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel)  updateNote,required TResult Function( Product product,  Flavor flavor,  SpicyLevel? selectedSpicyLevel,  String? note)  updateFlavor,required TResult Function( Product product,  SpicyLevel spicyLevel,  Flavor? selectedFlavor,  String? note)  updateSpicyLevel,required TResult Function( int itemIndex,  Flavor flavor)  updateFlavorByIndex,required TResult Function( int itemIndex,  SpicyLevel spicyLevel)  updateSpicyLevelByIndex,required TResult Function( int itemIndex,  String note)  updateNoteByIndex,required TResult Function( int itemIndex,  int quantity)  updateQuantityByIndex,required TResult Function( int itemIndex)  removeByIndex,required TResult Function()  clearCart,}) {final _that = this;
switch (_that) {
case _AddToCart():
return addToCart(_that.product,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _RemoveFromCart():
return removeFromCart(_that.product,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _UpdateQuantity():
return updateQuantity(_that.product,_that.quantity,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _UpdateNote():
return updateNote(_that.product,_that.note,_that.selectedFlavor,_that.selectedSpicyLevel);case _UpdateFlavor():
return updateFlavor(_that.product,_that.flavor,_that.selectedSpicyLevel,_that.note);case _UpdateSpicyLevel():
return updateSpicyLevel(_that.product,_that.spicyLevel,_that.selectedFlavor,_that.note);case _UpdateFlavorByIndex():
return updateFlavorByIndex(_that.itemIndex,_that.flavor);case _UpdateSpicyLevelByIndex():
return updateSpicyLevelByIndex(_that.itemIndex,_that.spicyLevel);case _UpdateNoteByIndex():
return updateNoteByIndex(_that.itemIndex,_that.note);case _UpdateQuantityByIndex():
return updateQuantityByIndex(_that.itemIndex,_that.quantity);case _RemoveByIndex():
return removeByIndex(_that.itemIndex);case _ClearCart():
return clearCart();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Product product,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)?  addToCart,TResult? Function( Product product,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)?  removeFromCart,TResult? Function( Product product,  int quantity,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel,  String? note)?  updateQuantity,TResult? Function( Product product,  String note,  Flavor? selectedFlavor,  SpicyLevel? selectedSpicyLevel)?  updateNote,TResult? Function( Product product,  Flavor flavor,  SpicyLevel? selectedSpicyLevel,  String? note)?  updateFlavor,TResult? Function( Product product,  SpicyLevel spicyLevel,  Flavor? selectedFlavor,  String? note)?  updateSpicyLevel,TResult? Function( int itemIndex,  Flavor flavor)?  updateFlavorByIndex,TResult? Function( int itemIndex,  SpicyLevel spicyLevel)?  updateSpicyLevelByIndex,TResult? Function( int itemIndex,  String note)?  updateNoteByIndex,TResult? Function( int itemIndex,  int quantity)?  updateQuantityByIndex,TResult? Function( int itemIndex)?  removeByIndex,TResult? Function()?  clearCart,}) {final _that = this;
switch (_that) {
case _AddToCart() when addToCart != null:
return addToCart(_that.product,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _RemoveFromCart() when removeFromCart != null:
return removeFromCart(_that.product,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _UpdateQuantity() when updateQuantity != null:
return updateQuantity(_that.product,_that.quantity,_that.selectedFlavor,_that.selectedSpicyLevel,_that.note);case _UpdateNote() when updateNote != null:
return updateNote(_that.product,_that.note,_that.selectedFlavor,_that.selectedSpicyLevel);case _UpdateFlavor() when updateFlavor != null:
return updateFlavor(_that.product,_that.flavor,_that.selectedSpicyLevel,_that.note);case _UpdateSpicyLevel() when updateSpicyLevel != null:
return updateSpicyLevel(_that.product,_that.spicyLevel,_that.selectedFlavor,_that.note);case _UpdateFlavorByIndex() when updateFlavorByIndex != null:
return updateFlavorByIndex(_that.itemIndex,_that.flavor);case _UpdateSpicyLevelByIndex() when updateSpicyLevelByIndex != null:
return updateSpicyLevelByIndex(_that.itemIndex,_that.spicyLevel);case _UpdateNoteByIndex() when updateNoteByIndex != null:
return updateNoteByIndex(_that.itemIndex,_that.note);case _UpdateQuantityByIndex() when updateQuantityByIndex != null:
return updateQuantityByIndex(_that.itemIndex,_that.quantity);case _RemoveByIndex() when removeByIndex != null:
return removeByIndex(_that.itemIndex);case _ClearCart() when clearCart != null:
return clearCart();case _:
  return null;

}
}

}

/// @nodoc


class _AddToCart implements CartEvent {
  const _AddToCart({required this.product, this.selectedFlavor, this.selectedSpicyLevel, this.note});
  

 final  Product product;
 final  Flavor? selectedFlavor;
 final  SpicyLevel? selectedSpicyLevel;
 final  String? note;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddToCartCopyWith<_AddToCart> get copyWith => __$AddToCartCopyWithImpl<_AddToCart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddToCart&&(identical(other.product, product) || other.product == product)&&(identical(other.selectedFlavor, selectedFlavor) || other.selectedFlavor == selectedFlavor)&&(identical(other.selectedSpicyLevel, selectedSpicyLevel) || other.selectedSpicyLevel == selectedSpicyLevel)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,product,selectedFlavor,selectedSpicyLevel,note);

@override
String toString() {
  return 'CartEvent.addToCart(product: $product, selectedFlavor: $selectedFlavor, selectedSpicyLevel: $selectedSpicyLevel, note: $note)';
}


}

/// @nodoc
abstract mixin class _$AddToCartCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$AddToCartCopyWith(_AddToCart value, $Res Function(_AddToCart) _then) = __$AddToCartCopyWithImpl;
@useResult
$Res call({
 Product product, Flavor? selectedFlavor, SpicyLevel? selectedSpicyLevel, String? note
});




}
/// @nodoc
class __$AddToCartCopyWithImpl<$Res>
    implements _$AddToCartCopyWith<$Res> {
  __$AddToCartCopyWithImpl(this._self, this._then);

  final _AddToCart _self;
  final $Res Function(_AddToCart) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? selectedFlavor = freezed,Object? selectedSpicyLevel = freezed,Object? note = freezed,}) {
  return _then(_AddToCart(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,selectedFlavor: freezed == selectedFlavor ? _self.selectedFlavor : selectedFlavor // ignore: cast_nullable_to_non_nullable
as Flavor?,selectedSpicyLevel: freezed == selectedSpicyLevel ? _self.selectedSpicyLevel : selectedSpicyLevel // ignore: cast_nullable_to_non_nullable
as SpicyLevel?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RemoveFromCart implements CartEvent {
  const _RemoveFromCart({required this.product, this.selectedFlavor, this.selectedSpicyLevel, this.note});
  

 final  Product product;
 final  Flavor? selectedFlavor;
 final  SpicyLevel? selectedSpicyLevel;
 final  String? note;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveFromCartCopyWith<_RemoveFromCart> get copyWith => __$RemoveFromCartCopyWithImpl<_RemoveFromCart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveFromCart&&(identical(other.product, product) || other.product == product)&&(identical(other.selectedFlavor, selectedFlavor) || other.selectedFlavor == selectedFlavor)&&(identical(other.selectedSpicyLevel, selectedSpicyLevel) || other.selectedSpicyLevel == selectedSpicyLevel)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,product,selectedFlavor,selectedSpicyLevel,note);

@override
String toString() {
  return 'CartEvent.removeFromCart(product: $product, selectedFlavor: $selectedFlavor, selectedSpicyLevel: $selectedSpicyLevel, note: $note)';
}


}

/// @nodoc
abstract mixin class _$RemoveFromCartCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$RemoveFromCartCopyWith(_RemoveFromCart value, $Res Function(_RemoveFromCart) _then) = __$RemoveFromCartCopyWithImpl;
@useResult
$Res call({
 Product product, Flavor? selectedFlavor, SpicyLevel? selectedSpicyLevel, String? note
});




}
/// @nodoc
class __$RemoveFromCartCopyWithImpl<$Res>
    implements _$RemoveFromCartCopyWith<$Res> {
  __$RemoveFromCartCopyWithImpl(this._self, this._then);

  final _RemoveFromCart _self;
  final $Res Function(_RemoveFromCart) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? selectedFlavor = freezed,Object? selectedSpicyLevel = freezed,Object? note = freezed,}) {
  return _then(_RemoveFromCart(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,selectedFlavor: freezed == selectedFlavor ? _self.selectedFlavor : selectedFlavor // ignore: cast_nullable_to_non_nullable
as Flavor?,selectedSpicyLevel: freezed == selectedSpicyLevel ? _self.selectedSpicyLevel : selectedSpicyLevel // ignore: cast_nullable_to_non_nullable
as SpicyLevel?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _UpdateQuantity implements CartEvent {
  const _UpdateQuantity({required this.product, required this.quantity, this.selectedFlavor, this.selectedSpicyLevel, this.note});
  

 final  Product product;
 final  int quantity;
 final  Flavor? selectedFlavor;
 final  SpicyLevel? selectedSpicyLevel;
 final  String? note;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateQuantityCopyWith<_UpdateQuantity> get copyWith => __$UpdateQuantityCopyWithImpl<_UpdateQuantity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateQuantity&&(identical(other.product, product) || other.product == product)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.selectedFlavor, selectedFlavor) || other.selectedFlavor == selectedFlavor)&&(identical(other.selectedSpicyLevel, selectedSpicyLevel) || other.selectedSpicyLevel == selectedSpicyLevel)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,product,quantity,selectedFlavor,selectedSpicyLevel,note);

@override
String toString() {
  return 'CartEvent.updateQuantity(product: $product, quantity: $quantity, selectedFlavor: $selectedFlavor, selectedSpicyLevel: $selectedSpicyLevel, note: $note)';
}


}

/// @nodoc
abstract mixin class _$UpdateQuantityCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$UpdateQuantityCopyWith(_UpdateQuantity value, $Res Function(_UpdateQuantity) _then) = __$UpdateQuantityCopyWithImpl;
@useResult
$Res call({
 Product product, int quantity, Flavor? selectedFlavor, SpicyLevel? selectedSpicyLevel, String? note
});




}
/// @nodoc
class __$UpdateQuantityCopyWithImpl<$Res>
    implements _$UpdateQuantityCopyWith<$Res> {
  __$UpdateQuantityCopyWithImpl(this._self, this._then);

  final _UpdateQuantity _self;
  final $Res Function(_UpdateQuantity) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? quantity = null,Object? selectedFlavor = freezed,Object? selectedSpicyLevel = freezed,Object? note = freezed,}) {
  return _then(_UpdateQuantity(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedFlavor: freezed == selectedFlavor ? _self.selectedFlavor : selectedFlavor // ignore: cast_nullable_to_non_nullable
as Flavor?,selectedSpicyLevel: freezed == selectedSpicyLevel ? _self.selectedSpicyLevel : selectedSpicyLevel // ignore: cast_nullable_to_non_nullable
as SpicyLevel?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _UpdateNote implements CartEvent {
  const _UpdateNote({required this.product, required this.note, this.selectedFlavor, this.selectedSpicyLevel});
  

 final  Product product;
 final  String note;
 final  Flavor? selectedFlavor;
 final  SpicyLevel? selectedSpicyLevel;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateNoteCopyWith<_UpdateNote> get copyWith => __$UpdateNoteCopyWithImpl<_UpdateNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateNote&&(identical(other.product, product) || other.product == product)&&(identical(other.note, note) || other.note == note)&&(identical(other.selectedFlavor, selectedFlavor) || other.selectedFlavor == selectedFlavor)&&(identical(other.selectedSpicyLevel, selectedSpicyLevel) || other.selectedSpicyLevel == selectedSpicyLevel));
}


@override
int get hashCode => Object.hash(runtimeType,product,note,selectedFlavor,selectedSpicyLevel);

@override
String toString() {
  return 'CartEvent.updateNote(product: $product, note: $note, selectedFlavor: $selectedFlavor, selectedSpicyLevel: $selectedSpicyLevel)';
}


}

/// @nodoc
abstract mixin class _$UpdateNoteCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$UpdateNoteCopyWith(_UpdateNote value, $Res Function(_UpdateNote) _then) = __$UpdateNoteCopyWithImpl;
@useResult
$Res call({
 Product product, String note, Flavor? selectedFlavor, SpicyLevel? selectedSpicyLevel
});




}
/// @nodoc
class __$UpdateNoteCopyWithImpl<$Res>
    implements _$UpdateNoteCopyWith<$Res> {
  __$UpdateNoteCopyWithImpl(this._self, this._then);

  final _UpdateNote _self;
  final $Res Function(_UpdateNote) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? note = null,Object? selectedFlavor = freezed,Object? selectedSpicyLevel = freezed,}) {
  return _then(_UpdateNote(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,selectedFlavor: freezed == selectedFlavor ? _self.selectedFlavor : selectedFlavor // ignore: cast_nullable_to_non_nullable
as Flavor?,selectedSpicyLevel: freezed == selectedSpicyLevel ? _self.selectedSpicyLevel : selectedSpicyLevel // ignore: cast_nullable_to_non_nullable
as SpicyLevel?,
  ));
}


}

/// @nodoc


class _UpdateFlavor implements CartEvent {
  const _UpdateFlavor({required this.product, required this.flavor, this.selectedSpicyLevel, this.note});
  

 final  Product product;
 final  Flavor flavor;
 final  SpicyLevel? selectedSpicyLevel;
 final  String? note;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateFlavorCopyWith<_UpdateFlavor> get copyWith => __$UpdateFlavorCopyWithImpl<_UpdateFlavor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateFlavor&&(identical(other.product, product) || other.product == product)&&(identical(other.flavor, flavor) || other.flavor == flavor)&&(identical(other.selectedSpicyLevel, selectedSpicyLevel) || other.selectedSpicyLevel == selectedSpicyLevel)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,product,flavor,selectedSpicyLevel,note);

@override
String toString() {
  return 'CartEvent.updateFlavor(product: $product, flavor: $flavor, selectedSpicyLevel: $selectedSpicyLevel, note: $note)';
}


}

/// @nodoc
abstract mixin class _$UpdateFlavorCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$UpdateFlavorCopyWith(_UpdateFlavor value, $Res Function(_UpdateFlavor) _then) = __$UpdateFlavorCopyWithImpl;
@useResult
$Res call({
 Product product, Flavor flavor, SpicyLevel? selectedSpicyLevel, String? note
});




}
/// @nodoc
class __$UpdateFlavorCopyWithImpl<$Res>
    implements _$UpdateFlavorCopyWith<$Res> {
  __$UpdateFlavorCopyWithImpl(this._self, this._then);

  final _UpdateFlavor _self;
  final $Res Function(_UpdateFlavor) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? flavor = null,Object? selectedSpicyLevel = freezed,Object? note = freezed,}) {
  return _then(_UpdateFlavor(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,flavor: null == flavor ? _self.flavor : flavor // ignore: cast_nullable_to_non_nullable
as Flavor,selectedSpicyLevel: freezed == selectedSpicyLevel ? _self.selectedSpicyLevel : selectedSpicyLevel // ignore: cast_nullable_to_non_nullable
as SpicyLevel?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _UpdateSpicyLevel implements CartEvent {
  const _UpdateSpicyLevel({required this.product, required this.spicyLevel, this.selectedFlavor, this.note});
  

 final  Product product;
 final  SpicyLevel spicyLevel;
 final  Flavor? selectedFlavor;
 final  String? note;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateSpicyLevelCopyWith<_UpdateSpicyLevel> get copyWith => __$UpdateSpicyLevelCopyWithImpl<_UpdateSpicyLevel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateSpicyLevel&&(identical(other.product, product) || other.product == product)&&(identical(other.spicyLevel, spicyLevel) || other.spicyLevel == spicyLevel)&&(identical(other.selectedFlavor, selectedFlavor) || other.selectedFlavor == selectedFlavor)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,product,spicyLevel,selectedFlavor,note);

@override
String toString() {
  return 'CartEvent.updateSpicyLevel(product: $product, spicyLevel: $spicyLevel, selectedFlavor: $selectedFlavor, note: $note)';
}


}

/// @nodoc
abstract mixin class _$UpdateSpicyLevelCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$UpdateSpicyLevelCopyWith(_UpdateSpicyLevel value, $Res Function(_UpdateSpicyLevel) _then) = __$UpdateSpicyLevelCopyWithImpl;
@useResult
$Res call({
 Product product, SpicyLevel spicyLevel, Flavor? selectedFlavor, String? note
});




}
/// @nodoc
class __$UpdateSpicyLevelCopyWithImpl<$Res>
    implements _$UpdateSpicyLevelCopyWith<$Res> {
  __$UpdateSpicyLevelCopyWithImpl(this._self, this._then);

  final _UpdateSpicyLevel _self;
  final $Res Function(_UpdateSpicyLevel) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,Object? spicyLevel = null,Object? selectedFlavor = freezed,Object? note = freezed,}) {
  return _then(_UpdateSpicyLevel(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,spicyLevel: null == spicyLevel ? _self.spicyLevel : spicyLevel // ignore: cast_nullable_to_non_nullable
as SpicyLevel,selectedFlavor: freezed == selectedFlavor ? _self.selectedFlavor : selectedFlavor // ignore: cast_nullable_to_non_nullable
as Flavor?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _UpdateFlavorByIndex implements CartEvent {
  const _UpdateFlavorByIndex({required this.itemIndex, required this.flavor});
  

 final  int itemIndex;
 final  Flavor flavor;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateFlavorByIndexCopyWith<_UpdateFlavorByIndex> get copyWith => __$UpdateFlavorByIndexCopyWithImpl<_UpdateFlavorByIndex>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateFlavorByIndex&&(identical(other.itemIndex, itemIndex) || other.itemIndex == itemIndex)&&(identical(other.flavor, flavor) || other.flavor == flavor));
}


@override
int get hashCode => Object.hash(runtimeType,itemIndex,flavor);

@override
String toString() {
  return 'CartEvent.updateFlavorByIndex(itemIndex: $itemIndex, flavor: $flavor)';
}


}

/// @nodoc
abstract mixin class _$UpdateFlavorByIndexCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$UpdateFlavorByIndexCopyWith(_UpdateFlavorByIndex value, $Res Function(_UpdateFlavorByIndex) _then) = __$UpdateFlavorByIndexCopyWithImpl;
@useResult
$Res call({
 int itemIndex, Flavor flavor
});




}
/// @nodoc
class __$UpdateFlavorByIndexCopyWithImpl<$Res>
    implements _$UpdateFlavorByIndexCopyWith<$Res> {
  __$UpdateFlavorByIndexCopyWithImpl(this._self, this._then);

  final _UpdateFlavorByIndex _self;
  final $Res Function(_UpdateFlavorByIndex) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemIndex = null,Object? flavor = null,}) {
  return _then(_UpdateFlavorByIndex(
itemIndex: null == itemIndex ? _self.itemIndex : itemIndex // ignore: cast_nullable_to_non_nullable
as int,flavor: null == flavor ? _self.flavor : flavor // ignore: cast_nullable_to_non_nullable
as Flavor,
  ));
}


}

/// @nodoc


class _UpdateSpicyLevelByIndex implements CartEvent {
  const _UpdateSpicyLevelByIndex({required this.itemIndex, required this.spicyLevel});
  

 final  int itemIndex;
 final  SpicyLevel spicyLevel;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateSpicyLevelByIndexCopyWith<_UpdateSpicyLevelByIndex> get copyWith => __$UpdateSpicyLevelByIndexCopyWithImpl<_UpdateSpicyLevelByIndex>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateSpicyLevelByIndex&&(identical(other.itemIndex, itemIndex) || other.itemIndex == itemIndex)&&(identical(other.spicyLevel, spicyLevel) || other.spicyLevel == spicyLevel));
}


@override
int get hashCode => Object.hash(runtimeType,itemIndex,spicyLevel);

@override
String toString() {
  return 'CartEvent.updateSpicyLevelByIndex(itemIndex: $itemIndex, spicyLevel: $spicyLevel)';
}


}

/// @nodoc
abstract mixin class _$UpdateSpicyLevelByIndexCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$UpdateSpicyLevelByIndexCopyWith(_UpdateSpicyLevelByIndex value, $Res Function(_UpdateSpicyLevelByIndex) _then) = __$UpdateSpicyLevelByIndexCopyWithImpl;
@useResult
$Res call({
 int itemIndex, SpicyLevel spicyLevel
});




}
/// @nodoc
class __$UpdateSpicyLevelByIndexCopyWithImpl<$Res>
    implements _$UpdateSpicyLevelByIndexCopyWith<$Res> {
  __$UpdateSpicyLevelByIndexCopyWithImpl(this._self, this._then);

  final _UpdateSpicyLevelByIndex _self;
  final $Res Function(_UpdateSpicyLevelByIndex) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemIndex = null,Object? spicyLevel = null,}) {
  return _then(_UpdateSpicyLevelByIndex(
itemIndex: null == itemIndex ? _self.itemIndex : itemIndex // ignore: cast_nullable_to_non_nullable
as int,spicyLevel: null == spicyLevel ? _self.spicyLevel : spicyLevel // ignore: cast_nullable_to_non_nullable
as SpicyLevel,
  ));
}


}

/// @nodoc


class _UpdateNoteByIndex implements CartEvent {
  const _UpdateNoteByIndex({required this.itemIndex, required this.note});
  

 final  int itemIndex;
 final  String note;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateNoteByIndexCopyWith<_UpdateNoteByIndex> get copyWith => __$UpdateNoteByIndexCopyWithImpl<_UpdateNoteByIndex>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateNoteByIndex&&(identical(other.itemIndex, itemIndex) || other.itemIndex == itemIndex)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,itemIndex,note);

@override
String toString() {
  return 'CartEvent.updateNoteByIndex(itemIndex: $itemIndex, note: $note)';
}


}

/// @nodoc
abstract mixin class _$UpdateNoteByIndexCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$UpdateNoteByIndexCopyWith(_UpdateNoteByIndex value, $Res Function(_UpdateNoteByIndex) _then) = __$UpdateNoteByIndexCopyWithImpl;
@useResult
$Res call({
 int itemIndex, String note
});




}
/// @nodoc
class __$UpdateNoteByIndexCopyWithImpl<$Res>
    implements _$UpdateNoteByIndexCopyWith<$Res> {
  __$UpdateNoteByIndexCopyWithImpl(this._self, this._then);

  final _UpdateNoteByIndex _self;
  final $Res Function(_UpdateNoteByIndex) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemIndex = null,Object? note = null,}) {
  return _then(_UpdateNoteByIndex(
itemIndex: null == itemIndex ? _self.itemIndex : itemIndex // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateQuantityByIndex implements CartEvent {
  const _UpdateQuantityByIndex({required this.itemIndex, required this.quantity});
  

 final  int itemIndex;
 final  int quantity;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateQuantityByIndexCopyWith<_UpdateQuantityByIndex> get copyWith => __$UpdateQuantityByIndexCopyWithImpl<_UpdateQuantityByIndex>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateQuantityByIndex&&(identical(other.itemIndex, itemIndex) || other.itemIndex == itemIndex)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,itemIndex,quantity);

@override
String toString() {
  return 'CartEvent.updateQuantityByIndex(itemIndex: $itemIndex, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$UpdateQuantityByIndexCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$UpdateQuantityByIndexCopyWith(_UpdateQuantityByIndex value, $Res Function(_UpdateQuantityByIndex) _then) = __$UpdateQuantityByIndexCopyWithImpl;
@useResult
$Res call({
 int itemIndex, int quantity
});




}
/// @nodoc
class __$UpdateQuantityByIndexCopyWithImpl<$Res>
    implements _$UpdateQuantityByIndexCopyWith<$Res> {
  __$UpdateQuantityByIndexCopyWithImpl(this._self, this._then);

  final _UpdateQuantityByIndex _self;
  final $Res Function(_UpdateQuantityByIndex) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemIndex = null,Object? quantity = null,}) {
  return _then(_UpdateQuantityByIndex(
itemIndex: null == itemIndex ? _self.itemIndex : itemIndex // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _RemoveByIndex implements CartEvent {
  const _RemoveByIndex({required this.itemIndex});
  

 final  int itemIndex;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveByIndexCopyWith<_RemoveByIndex> get copyWith => __$RemoveByIndexCopyWithImpl<_RemoveByIndex>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveByIndex&&(identical(other.itemIndex, itemIndex) || other.itemIndex == itemIndex));
}


@override
int get hashCode => Object.hash(runtimeType,itemIndex);

@override
String toString() {
  return 'CartEvent.removeByIndex(itemIndex: $itemIndex)';
}


}

/// @nodoc
abstract mixin class _$RemoveByIndexCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory _$RemoveByIndexCopyWith(_RemoveByIndex value, $Res Function(_RemoveByIndex) _then) = __$RemoveByIndexCopyWithImpl;
@useResult
$Res call({
 int itemIndex
});




}
/// @nodoc
class __$RemoveByIndexCopyWithImpl<$Res>
    implements _$RemoveByIndexCopyWith<$Res> {
  __$RemoveByIndexCopyWithImpl(this._self, this._then);

  final _RemoveByIndex _self;
  final $Res Function(_RemoveByIndex) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemIndex = null,}) {
  return _then(_RemoveByIndex(
itemIndex: null == itemIndex ? _self.itemIndex : itemIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ClearCart implements CartEvent {
  const _ClearCart();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearCart);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent.clearCart()';
}


}




/// @nodoc
mixin _$CartState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartState()';
}


}

/// @nodoc
class $CartStateCopyWith<$Res>  {
$CartStateCopyWith(CartState _, $Res Function(CartState) __);
}


/// Adds pattern-matching-related methods to [CartState].
extension CartStatePatterns on CartState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Updated value)?  updated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Updated() when updated != null:
return updated(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Updated value)  updated,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Updated():
return updated(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Updated value)?  updated,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Updated() when updated != null:
return updated(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<CartItemModel> items,  double totalPrice,  int totalQty)?  updated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Updated() when updated != null:
return updated(_that.items,_that.totalPrice,_that.totalQty);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<CartItemModel> items,  double totalPrice,  int totalQty)  updated,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Updated():
return updated(_that.items,_that.totalPrice,_that.totalQty);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<CartItemModel> items,  double totalPrice,  int totalQty)?  updated,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Updated() when updated != null:
return updated(_that.items,_that.totalPrice,_that.totalQty);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CartState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartState.initial()';
}


}




/// @nodoc


class _Updated implements CartState {
  const _Updated({required final  List<CartItemModel> items, required this.totalPrice, required this.totalQty}): _items = items;
  

 final  List<CartItemModel> _items;
 List<CartItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  double totalPrice;
 final  int totalQty;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatedCopyWith<_Updated> get copyWith => __$UpdatedCopyWithImpl<_Updated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Updated&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.totalQty, totalQty) || other.totalQty == totalQty));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalPrice,totalQty);

@override
String toString() {
  return 'CartState.updated(items: $items, totalPrice: $totalPrice, totalQty: $totalQty)';
}


}

/// @nodoc
abstract mixin class _$UpdatedCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$UpdatedCopyWith(_Updated value, $Res Function(_Updated) _then) = __$UpdatedCopyWithImpl;
@useResult
$Res call({
 List<CartItemModel> items, double totalPrice, int totalQty
});




}
/// @nodoc
class __$UpdatedCopyWithImpl<$Res>
    implements _$UpdatedCopyWith<$Res> {
  __$UpdatedCopyWithImpl(this._self, this._then);

  final _Updated _self;
  final $Res Function(_Updated) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalPrice = null,Object? totalQty = null,}) {
  return _then(_Updated(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemModel>,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,totalQty: null == totalQty ? _self.totalQty : totalQty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

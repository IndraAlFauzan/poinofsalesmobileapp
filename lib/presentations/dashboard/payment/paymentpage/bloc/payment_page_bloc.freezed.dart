// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_page_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentPageEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentPageEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentPageEvent()';
}


}

/// @nodoc
class $PaymentPageEventCopyWith<$Res>  {
$PaymentPageEventCopyWith(PaymentPageEvent _, $Res Function(PaymentPageEvent) __);
}


/// Adds pattern-matching-related methods to [PaymentPageEvent].
extension PaymentPageEventPatterns on PaymentPageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _UpdateTransactions value)?  updateTransactions,TResult Function( _SelectTable value)?  selectTable,TResult Function( _ToggleTransactionSelection value)?  toggleTransactionSelection,TResult Function( _ClearSelections value)?  clearSelections,TResult Function( _ValidateTableSelection value)?  validateTableSelection,TResult Function( _SetPaymentInfo value)?  setPaymentInfo,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateTransactions() when updateTransactions != null:
return updateTransactions(_that);case _SelectTable() when selectTable != null:
return selectTable(_that);case _ToggleTransactionSelection() when toggleTransactionSelection != null:
return toggleTransactionSelection(_that);case _ClearSelections() when clearSelections != null:
return clearSelections(_that);case _ValidateTableSelection() when validateTableSelection != null:
return validateTableSelection(_that);case _SetPaymentInfo() when setPaymentInfo != null:
return setPaymentInfo(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _UpdateTransactions value)  updateTransactions,required TResult Function( _SelectTable value)  selectTable,required TResult Function( _ToggleTransactionSelection value)  toggleTransactionSelection,required TResult Function( _ClearSelections value)  clearSelections,required TResult Function( _ValidateTableSelection value)  validateTableSelection,required TResult Function( _SetPaymentInfo value)  setPaymentInfo,}){
final _that = this;
switch (_that) {
case _UpdateTransactions():
return updateTransactions(_that);case _SelectTable():
return selectTable(_that);case _ToggleTransactionSelection():
return toggleTransactionSelection(_that);case _ClearSelections():
return clearSelections(_that);case _ValidateTableSelection():
return validateTableSelection(_that);case _SetPaymentInfo():
return setPaymentInfo(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _UpdateTransactions value)?  updateTransactions,TResult? Function( _SelectTable value)?  selectTable,TResult? Function( _ToggleTransactionSelection value)?  toggleTransactionSelection,TResult? Function( _ClearSelections value)?  clearSelections,TResult? Function( _ValidateTableSelection value)?  validateTableSelection,TResult? Function( _SetPaymentInfo value)?  setPaymentInfo,}){
final _that = this;
switch (_that) {
case _UpdateTransactions() when updateTransactions != null:
return updateTransactions(_that);case _SelectTable() when selectTable != null:
return selectTable(_that);case _ToggleTransactionSelection() when toggleTransactionSelection != null:
return toggleTransactionSelection(_that);case _ClearSelections() when clearSelections != null:
return clearSelections(_that);case _ValidateTableSelection() when validateTableSelection != null:
return validateTableSelection(_that);case _SetPaymentInfo() when setPaymentInfo != null:
return setPaymentInfo(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<PendingTransaction> transactions)?  updateTransactions,TResult Function( String? tableNo)?  selectTable,TResult Function( PendingTransaction transaction)?  toggleTransactionSelection,TResult Function()?  clearSelections,TResult Function()?  validateTableSelection,TResult Function( int paymentMethodId,  String paymentMethodName,  double? tenderedAmount,  String? note)?  setPaymentInfo,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateTransactions() when updateTransactions != null:
return updateTransactions(_that.transactions);case _SelectTable() when selectTable != null:
return selectTable(_that.tableNo);case _ToggleTransactionSelection() when toggleTransactionSelection != null:
return toggleTransactionSelection(_that.transaction);case _ClearSelections() when clearSelections != null:
return clearSelections();case _ValidateTableSelection() when validateTableSelection != null:
return validateTableSelection();case _SetPaymentInfo() when setPaymentInfo != null:
return setPaymentInfo(_that.paymentMethodId,_that.paymentMethodName,_that.tenderedAmount,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<PendingTransaction> transactions)  updateTransactions,required TResult Function( String? tableNo)  selectTable,required TResult Function( PendingTransaction transaction)  toggleTransactionSelection,required TResult Function()  clearSelections,required TResult Function()  validateTableSelection,required TResult Function( int paymentMethodId,  String paymentMethodName,  double? tenderedAmount,  String? note)  setPaymentInfo,}) {final _that = this;
switch (_that) {
case _UpdateTransactions():
return updateTransactions(_that.transactions);case _SelectTable():
return selectTable(_that.tableNo);case _ToggleTransactionSelection():
return toggleTransactionSelection(_that.transaction);case _ClearSelections():
return clearSelections();case _ValidateTableSelection():
return validateTableSelection();case _SetPaymentInfo():
return setPaymentInfo(_that.paymentMethodId,_that.paymentMethodName,_that.tenderedAmount,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<PendingTransaction> transactions)?  updateTransactions,TResult? Function( String? tableNo)?  selectTable,TResult? Function( PendingTransaction transaction)?  toggleTransactionSelection,TResult? Function()?  clearSelections,TResult? Function()?  validateTableSelection,TResult? Function( int paymentMethodId,  String paymentMethodName,  double? tenderedAmount,  String? note)?  setPaymentInfo,}) {final _that = this;
switch (_that) {
case _UpdateTransactions() when updateTransactions != null:
return updateTransactions(_that.transactions);case _SelectTable() when selectTable != null:
return selectTable(_that.tableNo);case _ToggleTransactionSelection() when toggleTransactionSelection != null:
return toggleTransactionSelection(_that.transaction);case _ClearSelections() when clearSelections != null:
return clearSelections();case _ValidateTableSelection() when validateTableSelection != null:
return validateTableSelection();case _SetPaymentInfo() when setPaymentInfo != null:
return setPaymentInfo(_that.paymentMethodId,_that.paymentMethodName,_that.tenderedAmount,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateTransactions implements PaymentPageEvent {
  const _UpdateTransactions({required final  List<PendingTransaction> transactions}): _transactions = transactions;
  

 final  List<PendingTransaction> _transactions;
 List<PendingTransaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of PaymentPageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTransactionsCopyWith<_UpdateTransactions> get copyWith => __$UpdateTransactionsCopyWithImpl<_UpdateTransactions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTransactions&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'PaymentPageEvent.updateTransactions(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$UpdateTransactionsCopyWith<$Res> implements $PaymentPageEventCopyWith<$Res> {
  factory _$UpdateTransactionsCopyWith(_UpdateTransactions value, $Res Function(_UpdateTransactions) _then) = __$UpdateTransactionsCopyWithImpl;
@useResult
$Res call({
 List<PendingTransaction> transactions
});




}
/// @nodoc
class __$UpdateTransactionsCopyWithImpl<$Res>
    implements _$UpdateTransactionsCopyWith<$Res> {
  __$UpdateTransactionsCopyWithImpl(this._self, this._then);

  final _UpdateTransactions _self;
  final $Res Function(_UpdateTransactions) _then;

/// Create a copy of PaymentPageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(_UpdateTransactions(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<PendingTransaction>,
  ));
}


}

/// @nodoc


class _SelectTable implements PaymentPageEvent {
  const _SelectTable({this.tableNo});
  

 final  String? tableNo;

/// Create a copy of PaymentPageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectTableCopyWith<_SelectTable> get copyWith => __$SelectTableCopyWithImpl<_SelectTable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectTable&&(identical(other.tableNo, tableNo) || other.tableNo == tableNo));
}


@override
int get hashCode => Object.hash(runtimeType,tableNo);

@override
String toString() {
  return 'PaymentPageEvent.selectTable(tableNo: $tableNo)';
}


}

/// @nodoc
abstract mixin class _$SelectTableCopyWith<$Res> implements $PaymentPageEventCopyWith<$Res> {
  factory _$SelectTableCopyWith(_SelectTable value, $Res Function(_SelectTable) _then) = __$SelectTableCopyWithImpl;
@useResult
$Res call({
 String? tableNo
});




}
/// @nodoc
class __$SelectTableCopyWithImpl<$Res>
    implements _$SelectTableCopyWith<$Res> {
  __$SelectTableCopyWithImpl(this._self, this._then);

  final _SelectTable _self;
  final $Res Function(_SelectTable) _then;

/// Create a copy of PaymentPageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tableNo = freezed,}) {
  return _then(_SelectTable(
tableNo: freezed == tableNo ? _self.tableNo : tableNo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ToggleTransactionSelection implements PaymentPageEvent {
  const _ToggleTransactionSelection({required this.transaction});
  

 final  PendingTransaction transaction;

/// Create a copy of PaymentPageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleTransactionSelectionCopyWith<_ToggleTransactionSelection> get copyWith => __$ToggleTransactionSelectionCopyWithImpl<_ToggleTransactionSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleTransactionSelection&&(identical(other.transaction, transaction) || other.transaction == transaction));
}


@override
int get hashCode => Object.hash(runtimeType,transaction);

@override
String toString() {
  return 'PaymentPageEvent.toggleTransactionSelection(transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class _$ToggleTransactionSelectionCopyWith<$Res> implements $PaymentPageEventCopyWith<$Res> {
  factory _$ToggleTransactionSelectionCopyWith(_ToggleTransactionSelection value, $Res Function(_ToggleTransactionSelection) _then) = __$ToggleTransactionSelectionCopyWithImpl;
@useResult
$Res call({
 PendingTransaction transaction
});




}
/// @nodoc
class __$ToggleTransactionSelectionCopyWithImpl<$Res>
    implements _$ToggleTransactionSelectionCopyWith<$Res> {
  __$ToggleTransactionSelectionCopyWithImpl(this._self, this._then);

  final _ToggleTransactionSelection _self;
  final $Res Function(_ToggleTransactionSelection) _then;

/// Create a copy of PaymentPageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transaction = null,}) {
  return _then(_ToggleTransactionSelection(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as PendingTransaction,
  ));
}


}

/// @nodoc


class _ClearSelections implements PaymentPageEvent {
  const _ClearSelections();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSelections);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentPageEvent.clearSelections()';
}


}




/// @nodoc


class _ValidateTableSelection implements PaymentPageEvent {
  const _ValidateTableSelection();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateTableSelection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentPageEvent.validateTableSelection()';
}


}




/// @nodoc


class _SetPaymentInfo implements PaymentPageEvent {
  const _SetPaymentInfo({required this.paymentMethodId, required this.paymentMethodName, this.tenderedAmount, this.note});
  

 final  int paymentMethodId;
 final  String paymentMethodName;
 final  double? tenderedAmount;
 final  String? note;

/// Create a copy of PaymentPageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetPaymentInfoCopyWith<_SetPaymentInfo> get copyWith => __$SetPaymentInfoCopyWithImpl<_SetPaymentInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetPaymentInfo&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.paymentMethodName, paymentMethodName) || other.paymentMethodName == paymentMethodName)&&(identical(other.tenderedAmount, tenderedAmount) || other.tenderedAmount == tenderedAmount)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,paymentMethodId,paymentMethodName,tenderedAmount,note);

@override
String toString() {
  return 'PaymentPageEvent.setPaymentInfo(paymentMethodId: $paymentMethodId, paymentMethodName: $paymentMethodName, tenderedAmount: $tenderedAmount, note: $note)';
}


}

/// @nodoc
abstract mixin class _$SetPaymentInfoCopyWith<$Res> implements $PaymentPageEventCopyWith<$Res> {
  factory _$SetPaymentInfoCopyWith(_SetPaymentInfo value, $Res Function(_SetPaymentInfo) _then) = __$SetPaymentInfoCopyWithImpl;
@useResult
$Res call({
 int paymentMethodId, String paymentMethodName, double? tenderedAmount, String? note
});




}
/// @nodoc
class __$SetPaymentInfoCopyWithImpl<$Res>
    implements _$SetPaymentInfoCopyWith<$Res> {
  __$SetPaymentInfoCopyWithImpl(this._self, this._then);

  final _SetPaymentInfo _self;
  final $Res Function(_SetPaymentInfo) _then;

/// Create a copy of PaymentPageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentMethodId = null,Object? paymentMethodName = null,Object? tenderedAmount = freezed,Object? note = freezed,}) {
  return _then(_SetPaymentInfo(
paymentMethodId: null == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as int,paymentMethodName: null == paymentMethodName ? _self.paymentMethodName : paymentMethodName // ignore: cast_nullable_to_non_nullable
as String,tenderedAmount: freezed == tenderedAmount ? _self.tenderedAmount : tenderedAmount // ignore: cast_nullable_to_non_nullable
as double?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PaymentPageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentPageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentPageState()';
}


}

/// @nodoc
class $PaymentPageStateCopyWith<$Res>  {
$PaymentPageStateCopyWith(PaymentPageState _, $Res Function(PaymentPageState) __);
}


/// Adds pattern-matching-related methods to [PaymentPageState].
extension PaymentPageStatePatterns on PaymentPageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loaded value)  loaded,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loaded():
return loaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loaded value)?  loaded,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<PendingTransaction> allTransactions,  String? selectedTableNo,  List<PendingTransaction> selectedTransactions,  List<String> availableTables,  int? paymentMethodId,  String? paymentMethodName,  double? tenderedAmount,  String? note)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loaded() when loaded != null:
return loaded(_that.allTransactions,_that.selectedTableNo,_that.selectedTransactions,_that.availableTables,_that.paymentMethodId,_that.paymentMethodName,_that.tenderedAmount,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<PendingTransaction> allTransactions,  String? selectedTableNo,  List<PendingTransaction> selectedTransactions,  List<String> availableTables,  int? paymentMethodId,  String? paymentMethodName,  double? tenderedAmount,  String? note)  loaded,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loaded():
return loaded(_that.allTransactions,_that.selectedTableNo,_that.selectedTransactions,_that.availableTables,_that.paymentMethodId,_that.paymentMethodName,_that.tenderedAmount,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<PendingTransaction> allTransactions,  String? selectedTableNo,  List<PendingTransaction> selectedTransactions,  List<String> availableTables,  int? paymentMethodId,  String? paymentMethodName,  double? tenderedAmount,  String? note)?  loaded,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loaded() when loaded != null:
return loaded(_that.allTransactions,_that.selectedTableNo,_that.selectedTransactions,_that.availableTables,_that.paymentMethodId,_that.paymentMethodName,_that.tenderedAmount,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PaymentPageState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentPageState.initial()';
}


}




/// @nodoc


class _Loaded implements PaymentPageState {
  const _Loaded({required final  List<PendingTransaction> allTransactions, this.selectedTableNo, final  List<PendingTransaction> selectedTransactions = const [], final  List<String> availableTables = const [], this.paymentMethodId, this.paymentMethodName, this.tenderedAmount, this.note}): _allTransactions = allTransactions,_selectedTransactions = selectedTransactions,_availableTables = availableTables;
  

 final  List<PendingTransaction> _allTransactions;
 List<PendingTransaction> get allTransactions {
  if (_allTransactions is EqualUnmodifiableListView) return _allTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allTransactions);
}

 final  String? selectedTableNo;
 final  List<PendingTransaction> _selectedTransactions;
@JsonKey() List<PendingTransaction> get selectedTransactions {
  if (_selectedTransactions is EqualUnmodifiableListView) return _selectedTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedTransactions);
}

 final  List<String> _availableTables;
@JsonKey() List<String> get availableTables {
  if (_availableTables is EqualUnmodifiableListView) return _availableTables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableTables);
}

 final  int? paymentMethodId;
 final  String? paymentMethodName;
 final  double? tenderedAmount;
 final  String? note;

/// Create a copy of PaymentPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._allTransactions, _allTransactions)&&(identical(other.selectedTableNo, selectedTableNo) || other.selectedTableNo == selectedTableNo)&&const DeepCollectionEquality().equals(other._selectedTransactions, _selectedTransactions)&&const DeepCollectionEquality().equals(other._availableTables, _availableTables)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.paymentMethodName, paymentMethodName) || other.paymentMethodName == paymentMethodName)&&(identical(other.tenderedAmount, tenderedAmount) || other.tenderedAmount == tenderedAmount)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allTransactions),selectedTableNo,const DeepCollectionEquality().hash(_selectedTransactions),const DeepCollectionEquality().hash(_availableTables),paymentMethodId,paymentMethodName,tenderedAmount,note);

@override
String toString() {
  return 'PaymentPageState.loaded(allTransactions: $allTransactions, selectedTableNo: $selectedTableNo, selectedTransactions: $selectedTransactions, availableTables: $availableTables, paymentMethodId: $paymentMethodId, paymentMethodName: $paymentMethodName, tenderedAmount: $tenderedAmount, note: $note)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $PaymentPageStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<PendingTransaction> allTransactions, String? selectedTableNo, List<PendingTransaction> selectedTransactions, List<String> availableTables, int? paymentMethodId, String? paymentMethodName, double? tenderedAmount, String? note
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of PaymentPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? allTransactions = null,Object? selectedTableNo = freezed,Object? selectedTransactions = null,Object? availableTables = null,Object? paymentMethodId = freezed,Object? paymentMethodName = freezed,Object? tenderedAmount = freezed,Object? note = freezed,}) {
  return _then(_Loaded(
allTransactions: null == allTransactions ? _self._allTransactions : allTransactions // ignore: cast_nullable_to_non_nullable
as List<PendingTransaction>,selectedTableNo: freezed == selectedTableNo ? _self.selectedTableNo : selectedTableNo // ignore: cast_nullable_to_non_nullable
as String?,selectedTransactions: null == selectedTransactions ? _self._selectedTransactions : selectedTransactions // ignore: cast_nullable_to_non_nullable
as List<PendingTransaction>,availableTables: null == availableTables ? _self._availableTables : availableTables // ignore: cast_nullable_to_non_nullable
as List<String>,paymentMethodId: freezed == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as int?,paymentMethodName: freezed == paymentMethodName ? _self.paymentMethodName : paymentMethodName // ignore: cast_nullable_to_non_nullable
as String?,tenderedAmount: freezed == tenderedAmount ? _self.tenderedAmount : tenderedAmount // ignore: cast_nullable_to_non_nullable
as double?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

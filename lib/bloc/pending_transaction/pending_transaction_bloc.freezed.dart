// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_transaction_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PendingTransactionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingTransactionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PendingTransactionEvent()';
}


}

/// @nodoc
class $PendingTransactionEventCopyWith<$Res>  {
$PendingTransactionEventCopyWith(PendingTransactionEvent _, $Res Function(PendingTransactionEvent) __);
}


/// Adds pattern-matching-related methods to [PendingTransactionEvent].
extension PendingTransactionEventPatterns on PendingTransactionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FetchPendingTransactions value)?  fetchPendingTransactions,TResult Function( _CreateTransaction value)?  createTransaction,TResult Function( _EditTransaction value)?  editTransaction,TResult Function( _RefreshTransactions value)?  refreshTransactions,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchPendingTransactions() when fetchPendingTransactions != null:
return fetchPendingTransactions(_that);case _CreateTransaction() when createTransaction != null:
return createTransaction(_that);case _EditTransaction() when editTransaction != null:
return editTransaction(_that);case _RefreshTransactions() when refreshTransactions != null:
return refreshTransactions(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FetchPendingTransactions value)  fetchPendingTransactions,required TResult Function( _CreateTransaction value)  createTransaction,required TResult Function( _EditTransaction value)  editTransaction,required TResult Function( _RefreshTransactions value)  refreshTransactions,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FetchPendingTransactions():
return fetchPendingTransactions(_that);case _CreateTransaction():
return createTransaction(_that);case _EditTransaction():
return editTransaction(_that);case _RefreshTransactions():
return refreshTransactions(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FetchPendingTransactions value)?  fetchPendingTransactions,TResult? Function( _CreateTransaction value)?  createTransaction,TResult? Function( _EditTransaction value)?  editTransaction,TResult? Function( _RefreshTransactions value)?  refreshTransactions,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchPendingTransactions() when fetchPendingTransactions != null:
return fetchPendingTransactions(_that);case _CreateTransaction() when createTransaction != null:
return createTransaction(_that);case _EditTransaction() when editTransaction != null:
return editTransaction(_that);case _RefreshTransactions() when refreshTransactions != null:
return refreshTransactions(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  fetchPendingTransactions,TResult Function( CreateTransactionRequest request)?  createTransaction,TResult Function( int transactionId,  EditTransactionRequest request)?  editTransaction,TResult Function()?  refreshTransactions,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchPendingTransactions() when fetchPendingTransactions != null:
return fetchPendingTransactions();case _CreateTransaction() when createTransaction != null:
return createTransaction(_that.request);case _EditTransaction() when editTransaction != null:
return editTransaction(_that.transactionId,_that.request);case _RefreshTransactions() when refreshTransactions != null:
return refreshTransactions();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  fetchPendingTransactions,required TResult Function( CreateTransactionRequest request)  createTransaction,required TResult Function( int transactionId,  EditTransactionRequest request)  editTransaction,required TResult Function()  refreshTransactions,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FetchPendingTransactions():
return fetchPendingTransactions();case _CreateTransaction():
return createTransaction(_that.request);case _EditTransaction():
return editTransaction(_that.transactionId,_that.request);case _RefreshTransactions():
return refreshTransactions();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  fetchPendingTransactions,TResult? Function( CreateTransactionRequest request)?  createTransaction,TResult? Function( int transactionId,  EditTransactionRequest request)?  editTransaction,TResult? Function()?  refreshTransactions,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchPendingTransactions() when fetchPendingTransactions != null:
return fetchPendingTransactions();case _CreateTransaction() when createTransaction != null:
return createTransaction(_that.request);case _EditTransaction() when editTransaction != null:
return editTransaction(_that.transactionId,_that.request);case _RefreshTransactions() when refreshTransactions != null:
return refreshTransactions();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements PendingTransactionEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PendingTransactionEvent.started()';
}


}




/// @nodoc


class _FetchPendingTransactions implements PendingTransactionEvent {
  const _FetchPendingTransactions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchPendingTransactions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PendingTransactionEvent.fetchPendingTransactions()';
}


}




/// @nodoc


class _CreateTransaction implements PendingTransactionEvent {
  const _CreateTransaction({required this.request});
  

 final  CreateTransactionRequest request;

/// Create a copy of PendingTransactionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTransactionCopyWith<_CreateTransaction> get copyWith => __$CreateTransactionCopyWithImpl<_CreateTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTransaction&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'PendingTransactionEvent.createTransaction(request: $request)';
}


}

/// @nodoc
abstract mixin class _$CreateTransactionCopyWith<$Res> implements $PendingTransactionEventCopyWith<$Res> {
  factory _$CreateTransactionCopyWith(_CreateTransaction value, $Res Function(_CreateTransaction) _then) = __$CreateTransactionCopyWithImpl;
@useResult
$Res call({
 CreateTransactionRequest request
});




}
/// @nodoc
class __$CreateTransactionCopyWithImpl<$Res>
    implements _$CreateTransactionCopyWith<$Res> {
  __$CreateTransactionCopyWithImpl(this._self, this._then);

  final _CreateTransaction _self;
  final $Res Function(_CreateTransaction) _then;

/// Create a copy of PendingTransactionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(_CreateTransaction(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as CreateTransactionRequest,
  ));
}


}

/// @nodoc


class _EditTransaction implements PendingTransactionEvent {
  const _EditTransaction({required this.transactionId, required this.request});
  

 final  int transactionId;
 final  EditTransactionRequest request;

/// Create a copy of PendingTransactionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditTransactionCopyWith<_EditTransaction> get copyWith => __$EditTransactionCopyWithImpl<_EditTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditTransaction&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,request);

@override
String toString() {
  return 'PendingTransactionEvent.editTransaction(transactionId: $transactionId, request: $request)';
}


}

/// @nodoc
abstract mixin class _$EditTransactionCopyWith<$Res> implements $PendingTransactionEventCopyWith<$Res> {
  factory _$EditTransactionCopyWith(_EditTransaction value, $Res Function(_EditTransaction) _then) = __$EditTransactionCopyWithImpl;
@useResult
$Res call({
 int transactionId, EditTransactionRequest request
});




}
/// @nodoc
class __$EditTransactionCopyWithImpl<$Res>
    implements _$EditTransactionCopyWith<$Res> {
  __$EditTransactionCopyWithImpl(this._self, this._then);

  final _EditTransaction _self;
  final $Res Function(_EditTransaction) _then;

/// Create a copy of PendingTransactionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? request = null,}) {
  return _then(_EditTransaction(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as EditTransactionRequest,
  ));
}


}

/// @nodoc


class _RefreshTransactions implements PendingTransactionEvent {
  const _RefreshTransactions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshTransactions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PendingTransactionEvent.refreshTransactions()';
}


}




/// @nodoc
mixin _$PendingTransactionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingTransactionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PendingTransactionState()';
}


}

/// @nodoc
class $PendingTransactionStateCopyWith<$Res>  {
$PendingTransactionStateCopyWith(PendingTransactionState _, $Res Function(PendingTransactionState) __);
}


/// Adds pattern-matching-related methods to [PendingTransactionState].
extension PendingTransactionStatePatterns on PendingTransactionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,TResult Function( _TransactionCreated value)?  transactionCreated,TResult Function( _TransactionUpdated value)?  transactionUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _TransactionCreated() when transactionCreated != null:
return transactionCreated(_that);case _TransactionUpdated() when transactionUpdated != null:
return transactionUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,required TResult Function( _TransactionCreated value)  transactionCreated,required TResult Function( _TransactionUpdated value)  transactionUpdated,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _TransactionCreated():
return transactionCreated(_that);case _TransactionUpdated():
return transactionUpdated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,TResult? Function( _TransactionCreated value)?  transactionCreated,TResult? Function( _TransactionUpdated value)?  transactionUpdated,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _TransactionCreated() when transactionCreated != null:
return transactionCreated(_that);case _TransactionUpdated() when transactionUpdated != null:
return transactionUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<PendingTransaction> transactions)?  success,TResult Function( String message)?  failure,TResult Function( TransactionResponse response)?  transactionCreated,TResult Function( TransactionResponse response)?  transactionUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.transactions);case _Failure() when failure != null:
return failure(_that.message);case _TransactionCreated() when transactionCreated != null:
return transactionCreated(_that.response);case _TransactionUpdated() when transactionUpdated != null:
return transactionUpdated(_that.response);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<PendingTransaction> transactions)  success,required TResult Function( String message)  failure,required TResult Function( TransactionResponse response)  transactionCreated,required TResult Function( TransactionResponse response)  transactionUpdated,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.transactions);case _Failure():
return failure(_that.message);case _TransactionCreated():
return transactionCreated(_that.response);case _TransactionUpdated():
return transactionUpdated(_that.response);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<PendingTransaction> transactions)?  success,TResult? Function( String message)?  failure,TResult? Function( TransactionResponse response)?  transactionCreated,TResult? Function( TransactionResponse response)?  transactionUpdated,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.transactions);case _Failure() when failure != null:
return failure(_that.message);case _TransactionCreated() when transactionCreated != null:
return transactionCreated(_that.response);case _TransactionUpdated() when transactionUpdated != null:
return transactionUpdated(_that.response);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PendingTransactionState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PendingTransactionState.initial()';
}


}




/// @nodoc


class _Loading implements PendingTransactionState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PendingTransactionState.loading()';
}


}




/// @nodoc


class _Success implements PendingTransactionState {
  const _Success({required final  List<PendingTransaction> transactions}): _transactions = transactions;
  

 final  List<PendingTransaction> _transactions;
 List<PendingTransaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of PendingTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'PendingTransactionState.success(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $PendingTransactionStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 List<PendingTransaction> transactions
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of PendingTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(_Success(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<PendingTransaction>,
  ));
}


}

/// @nodoc


class _Failure implements PendingTransactionState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of PendingTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PendingTransactionState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $PendingTransactionStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of PendingTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TransactionCreated implements PendingTransactionState {
  const _TransactionCreated({required this.response});
  

 final  TransactionResponse response;

/// Create a copy of PendingTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCreatedCopyWith<_TransactionCreated> get copyWith => __$TransactionCreatedCopyWithImpl<_TransactionCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionCreated&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'PendingTransactionState.transactionCreated(response: $response)';
}


}

/// @nodoc
abstract mixin class _$TransactionCreatedCopyWith<$Res> implements $PendingTransactionStateCopyWith<$Res> {
  factory _$TransactionCreatedCopyWith(_TransactionCreated value, $Res Function(_TransactionCreated) _then) = __$TransactionCreatedCopyWithImpl;
@useResult
$Res call({
 TransactionResponse response
});




}
/// @nodoc
class __$TransactionCreatedCopyWithImpl<$Res>
    implements _$TransactionCreatedCopyWith<$Res> {
  __$TransactionCreatedCopyWithImpl(this._self, this._then);

  final _TransactionCreated _self;
  final $Res Function(_TransactionCreated) _then;

/// Create a copy of PendingTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_TransactionCreated(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as TransactionResponse,
  ));
}


}

/// @nodoc


class _TransactionUpdated implements PendingTransactionState {
  const _TransactionUpdated({required this.response});
  

 final  TransactionResponse response;

/// Create a copy of PendingTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionUpdatedCopyWith<_TransactionUpdated> get copyWith => __$TransactionUpdatedCopyWithImpl<_TransactionUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionUpdated&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'PendingTransactionState.transactionUpdated(response: $response)';
}


}

/// @nodoc
abstract mixin class _$TransactionUpdatedCopyWith<$Res> implements $PendingTransactionStateCopyWith<$Res> {
  factory _$TransactionUpdatedCopyWith(_TransactionUpdated value, $Res Function(_TransactionUpdated) _then) = __$TransactionUpdatedCopyWithImpl;
@useResult
$Res call({
 TransactionResponse response
});




}
/// @nodoc
class __$TransactionUpdatedCopyWithImpl<$Res>
    implements _$TransactionUpdatedCopyWith<$Res> {
  __$TransactionUpdatedCopyWithImpl(this._self, this._then);

  final _TransactionUpdated _self;
  final $Res Function(_TransactionUpdated) _then;

/// Create a copy of PendingTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_TransactionUpdated(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as TransactionResponse,
  ));
}


}

// dart format on

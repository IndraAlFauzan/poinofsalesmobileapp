// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_transaction_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryTransactionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryTransactionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionEvent()';
}


}

/// @nodoc
class $HistoryTransactionEventCopyWith<$Res>  {
$HistoryTransactionEventCopyWith(HistoryTransactionEvent _, $Res Function(HistoryTransactionEvent) __);
}


/// Adds pattern-matching-related methods to [HistoryTransactionEvent].
extension HistoryTransactionEventPatterns on HistoryTransactionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FetchAllTransactions value)?  fetchAllTransactions,TResult Function( _RefreshTransactions value)?  refreshTransactions,TResult Function( _SearchTransactions value)?  searchTransactions,TResult Function( _FilterTransactions value)?  filterTransactions,TResult Function( _ClearFilters value)?  clearFilters,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchAllTransactions() when fetchAllTransactions != null:
return fetchAllTransactions(_that);case _RefreshTransactions() when refreshTransactions != null:
return refreshTransactions(_that);case _SearchTransactions() when searchTransactions != null:
return searchTransactions(_that);case _FilterTransactions() when filterTransactions != null:
return filterTransactions(_that);case _ClearFilters() when clearFilters != null:
return clearFilters(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FetchAllTransactions value)  fetchAllTransactions,required TResult Function( _RefreshTransactions value)  refreshTransactions,required TResult Function( _SearchTransactions value)  searchTransactions,required TResult Function( _FilterTransactions value)  filterTransactions,required TResult Function( _ClearFilters value)  clearFilters,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FetchAllTransactions():
return fetchAllTransactions(_that);case _RefreshTransactions():
return refreshTransactions(_that);case _SearchTransactions():
return searchTransactions(_that);case _FilterTransactions():
return filterTransactions(_that);case _ClearFilters():
return clearFilters(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FetchAllTransactions value)?  fetchAllTransactions,TResult? Function( _RefreshTransactions value)?  refreshTransactions,TResult? Function( _SearchTransactions value)?  searchTransactions,TResult? Function( _FilterTransactions value)?  filterTransactions,TResult? Function( _ClearFilters value)?  clearFilters,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchAllTransactions() when fetchAllTransactions != null:
return fetchAllTransactions(_that);case _RefreshTransactions() when refreshTransactions != null:
return refreshTransactions(_that);case _SearchTransactions() when searchTransactions != null:
return searchTransactions(_that);case _FilterTransactions() when filterTransactions != null:
return filterTransactions(_that);case _ClearFilters() when clearFilters != null:
return clearFilters(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  fetchAllTransactions,TResult Function()?  refreshTransactions,TResult Function( String query)?  searchTransactions,TResult Function( TransactionFilter filter)?  filterTransactions,TResult Function()?  clearFilters,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchAllTransactions() when fetchAllTransactions != null:
return fetchAllTransactions();case _RefreshTransactions() when refreshTransactions != null:
return refreshTransactions();case _SearchTransactions() when searchTransactions != null:
return searchTransactions(_that.query);case _FilterTransactions() when filterTransactions != null:
return filterTransactions(_that.filter);case _ClearFilters() when clearFilters != null:
return clearFilters();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  fetchAllTransactions,required TResult Function()  refreshTransactions,required TResult Function( String query)  searchTransactions,required TResult Function( TransactionFilter filter)  filterTransactions,required TResult Function()  clearFilters,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FetchAllTransactions():
return fetchAllTransactions();case _RefreshTransactions():
return refreshTransactions();case _SearchTransactions():
return searchTransactions(_that.query);case _FilterTransactions():
return filterTransactions(_that.filter);case _ClearFilters():
return clearFilters();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  fetchAllTransactions,TResult? Function()?  refreshTransactions,TResult? Function( String query)?  searchTransactions,TResult? Function( TransactionFilter filter)?  filterTransactions,TResult? Function()?  clearFilters,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchAllTransactions() when fetchAllTransactions != null:
return fetchAllTransactions();case _RefreshTransactions() when refreshTransactions != null:
return refreshTransactions();case _SearchTransactions() when searchTransactions != null:
return searchTransactions(_that.query);case _FilterTransactions() when filterTransactions != null:
return filterTransactions(_that.filter);case _ClearFilters() when clearFilters != null:
return clearFilters();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements HistoryTransactionEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionEvent.started()';
}


}




/// @nodoc


class _FetchAllTransactions implements HistoryTransactionEvent {
  const _FetchAllTransactions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchAllTransactions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionEvent.fetchAllTransactions()';
}


}




/// @nodoc


class _RefreshTransactions implements HistoryTransactionEvent {
  const _RefreshTransactions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshTransactions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionEvent.refreshTransactions()';
}


}




/// @nodoc


class _SearchTransactions implements HistoryTransactionEvent {
  const _SearchTransactions(this.query);
  

 final  String query;

/// Create a copy of HistoryTransactionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchTransactionsCopyWith<_SearchTransactions> get copyWith => __$SearchTransactionsCopyWithImpl<_SearchTransactions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchTransactions&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'HistoryTransactionEvent.searchTransactions(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchTransactionsCopyWith<$Res> implements $HistoryTransactionEventCopyWith<$Res> {
  factory _$SearchTransactionsCopyWith(_SearchTransactions value, $Res Function(_SearchTransactions) _then) = __$SearchTransactionsCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchTransactionsCopyWithImpl<$Res>
    implements _$SearchTransactionsCopyWith<$Res> {
  __$SearchTransactionsCopyWithImpl(this._self, this._then);

  final _SearchTransactions _self;
  final $Res Function(_SearchTransactions) _then;

/// Create a copy of HistoryTransactionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchTransactions(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FilterTransactions implements HistoryTransactionEvent {
  const _FilterTransactions(this.filter);
  

 final  TransactionFilter filter;

/// Create a copy of HistoryTransactionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterTransactionsCopyWith<_FilterTransactions> get copyWith => __$FilterTransactionsCopyWithImpl<_FilterTransactions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterTransactions&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'HistoryTransactionEvent.filterTransactions(filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$FilterTransactionsCopyWith<$Res> implements $HistoryTransactionEventCopyWith<$Res> {
  factory _$FilterTransactionsCopyWith(_FilterTransactions value, $Res Function(_FilterTransactions) _then) = __$FilterTransactionsCopyWithImpl;
@useResult
$Res call({
 TransactionFilter filter
});




}
/// @nodoc
class __$FilterTransactionsCopyWithImpl<$Res>
    implements _$FilterTransactionsCopyWith<$Res> {
  __$FilterTransactionsCopyWithImpl(this._self, this._then);

  final _FilterTransactions _self;
  final $Res Function(_FilterTransactions) _then;

/// Create a copy of HistoryTransactionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(_FilterTransactions(
null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TransactionFilter,
  ));
}


}

/// @nodoc


class _ClearFilters implements HistoryTransactionEvent {
  const _ClearFilters();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearFilters);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionEvent.clearFilters()';
}


}




/// @nodoc
mixin _$HistoryTransactionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryTransactionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionState()';
}


}

/// @nodoc
class $HistoryTransactionStateCopyWith<$Res>  {
$HistoryTransactionStateCopyWith(HistoryTransactionState _, $Res Function(HistoryTransactionState) __);
}


/// Adds pattern-matching-related methods to [HistoryTransactionState].
extension HistoryTransactionStatePatterns on HistoryTransactionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Refreshing value)?  refreshing,TResult Function( _Failure value)?  failure,TResult Function( _Success value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Refreshing() when refreshing != null:
return refreshing(_that);case _Failure() when failure != null:
return failure(_that);case _Success() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Refreshing value)  refreshing,required TResult Function( _Failure value)  failure,required TResult Function( _Success value)  success,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Refreshing():
return refreshing(_that);case _Failure():
return failure(_that);case _Success():
return success(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Refreshing value)?  refreshing,TResult? Function( _Failure value)?  failure,TResult? Function( _Success value)?  success,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Refreshing() when refreshing != null:
return refreshing(_that);case _Failure() when failure != null:
return failure(_that);case _Success() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  refreshing,TResult Function( String message)?  failure,TResult Function( AllTransactionModelResponse transactions)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Refreshing() when refreshing != null:
return refreshing();case _Failure() when failure != null:
return failure(_that.message);case _Success() when success != null:
return success(_that.transactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  refreshing,required TResult Function( String message)  failure,required TResult Function( AllTransactionModelResponse transactions)  success,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Refreshing():
return refreshing();case _Failure():
return failure(_that.message);case _Success():
return success(_that.transactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  refreshing,TResult? Function( String message)?  failure,TResult? Function( AllTransactionModelResponse transactions)?  success,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Refreshing() when refreshing != null:
return refreshing();case _Failure() when failure != null:
return failure(_that.message);case _Success() when success != null:
return success(_that.transactions);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements HistoryTransactionState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionState.initial()';
}


}




/// @nodoc


class _Loading implements HistoryTransactionState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionState.loading()';
}


}




/// @nodoc


class _Refreshing implements HistoryTransactionState {
  const _Refreshing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refreshing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryTransactionState.refreshing()';
}


}




/// @nodoc


class _Failure implements HistoryTransactionState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of HistoryTransactionState
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
  return 'HistoryTransactionState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $HistoryTransactionStateCopyWith<$Res> {
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

/// Create a copy of HistoryTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Success implements HistoryTransactionState {
  const _Success(this.transactions);
  

 final  AllTransactionModelResponse transactions;

/// Create a copy of HistoryTransactionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.transactions, transactions) || other.transactions == transactions));
}


@override
int get hashCode => Object.hash(runtimeType,transactions);

@override
String toString() {
  return 'HistoryTransactionState.success(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $HistoryTransactionStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 AllTransactionModelResponse transactions
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of HistoryTransactionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(_Success(
null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as AllTransactionModelResponse,
  ));
}


}

// dart format on

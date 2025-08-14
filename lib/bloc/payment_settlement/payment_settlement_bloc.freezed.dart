// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_settlement_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentSettlementEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentSettlementEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentSettlementEvent()';
}


}

/// @nodoc
class $PaymentSettlementEventCopyWith<$Res>  {
$PaymentSettlementEventCopyWith(PaymentSettlementEvent _, $Res Function(PaymentSettlementEvent) __);
}


/// Adds pattern-matching-related methods to [PaymentSettlementEvent].
extension PaymentSettlementEventPatterns on PaymentSettlementEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FetchPayments value)?  fetchPayments,TResult Function( _SettlePayment value)?  settlePayment,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchPayments() when fetchPayments != null:
return fetchPayments(_that);case _SettlePayment() when settlePayment != null:
return settlePayment(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FetchPayments value)  fetchPayments,required TResult Function( _SettlePayment value)  settlePayment,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FetchPayments():
return fetchPayments(_that);case _SettlePayment():
return settlePayment(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FetchPayments value)?  fetchPayments,TResult? Function( _SettlePayment value)?  settlePayment,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchPayments() when fetchPayments != null:
return fetchPayments(_that);case _SettlePayment() when settlePayment != null:
return settlePayment(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  fetchPayments,TResult Function( PaymentSettleRequest request)?  settlePayment,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchPayments() when fetchPayments != null:
return fetchPayments();case _SettlePayment() when settlePayment != null:
return settlePayment(_that.request);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  fetchPayments,required TResult Function( PaymentSettleRequest request)  settlePayment,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FetchPayments():
return fetchPayments();case _SettlePayment():
return settlePayment(_that.request);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  fetchPayments,TResult? Function( PaymentSettleRequest request)?  settlePayment,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchPayments() when fetchPayments != null:
return fetchPayments();case _SettlePayment() when settlePayment != null:
return settlePayment(_that.request);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements PaymentSettlementEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentSettlementEvent.started()';
}


}




/// @nodoc


class _FetchPayments implements PaymentSettlementEvent {
  const _FetchPayments();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchPayments);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentSettlementEvent.fetchPayments()';
}


}




/// @nodoc


class _SettlePayment implements PaymentSettlementEvent {
  const _SettlePayment({required this.request});
  

 final  PaymentSettleRequest request;

/// Create a copy of PaymentSettlementEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlePaymentCopyWith<_SettlePayment> get copyWith => __$SettlePaymentCopyWithImpl<_SettlePayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlePayment&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'PaymentSettlementEvent.settlePayment(request: $request)';
}


}

/// @nodoc
abstract mixin class _$SettlePaymentCopyWith<$Res> implements $PaymentSettlementEventCopyWith<$Res> {
  factory _$SettlePaymentCopyWith(_SettlePayment value, $Res Function(_SettlePayment) _then) = __$SettlePaymentCopyWithImpl;
@useResult
$Res call({
 PaymentSettleRequest request
});




}
/// @nodoc
class __$SettlePaymentCopyWithImpl<$Res>
    implements _$SettlePaymentCopyWith<$Res> {
  __$SettlePaymentCopyWithImpl(this._self, this._then);

  final _SettlePayment _self;
  final $Res Function(_SettlePayment) _then;

/// Create a copy of PaymentSettlementEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(_SettlePayment(
request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as PaymentSettleRequest,
  ));
}


}

/// @nodoc
mixin _$PaymentSettlementState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentSettlementState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentSettlementState()';
}


}

/// @nodoc
class $PaymentSettlementStateCopyWith<$Res>  {
$PaymentSettlementStateCopyWith(PaymentSettlementState _, $Res Function(PaymentSettlementState) __);
}


/// Adds pattern-matching-related methods to [PaymentSettlementState].
extension PaymentSettlementStatePatterns on PaymentSettlementState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _PaymentsLoaded value)?  paymentsLoaded,TResult Function( _PaymentSettled value)?  paymentSettled,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _PaymentsLoaded() when paymentsLoaded != null:
return paymentsLoaded(_that);case _PaymentSettled() when paymentSettled != null:
return paymentSettled(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _PaymentsLoaded value)  paymentsLoaded,required TResult Function( _PaymentSettled value)  paymentSettled,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _PaymentsLoaded():
return paymentsLoaded(_that);case _PaymentSettled():
return paymentSettled(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _PaymentsLoaded value)?  paymentsLoaded,TResult? Function( _PaymentSettled value)?  paymentSettled,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _PaymentsLoaded() when paymentsLoaded != null:
return paymentsLoaded(_that);case _PaymentSettled() when paymentSettled != null:
return paymentSettled(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<PaymentData> payments)?  paymentsLoaded,TResult Function( PaymentSettleResponse response)?  paymentSettled,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _PaymentsLoaded() when paymentsLoaded != null:
return paymentsLoaded(_that.payments);case _PaymentSettled() when paymentSettled != null:
return paymentSettled(_that.response);case _Failure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<PaymentData> payments)  paymentsLoaded,required TResult Function( PaymentSettleResponse response)  paymentSettled,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _PaymentsLoaded():
return paymentsLoaded(_that.payments);case _PaymentSettled():
return paymentSettled(_that.response);case _Failure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<PaymentData> payments)?  paymentsLoaded,TResult? Function( PaymentSettleResponse response)?  paymentSettled,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _PaymentsLoaded() when paymentsLoaded != null:
return paymentsLoaded(_that.payments);case _PaymentSettled() when paymentSettled != null:
return paymentSettled(_that.response);case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PaymentSettlementState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentSettlementState.initial()';
}


}




/// @nodoc


class _Loading implements PaymentSettlementState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentSettlementState.loading()';
}


}




/// @nodoc


class _PaymentsLoaded implements PaymentSettlementState {
  const _PaymentsLoaded({required final  List<PaymentData> payments}): _payments = payments;
  

 final  List<PaymentData> _payments;
 List<PaymentData> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}


/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentsLoadedCopyWith<_PaymentsLoaded> get copyWith => __$PaymentsLoadedCopyWithImpl<_PaymentsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentsLoaded&&const DeepCollectionEquality().equals(other._payments, _payments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_payments));

@override
String toString() {
  return 'PaymentSettlementState.paymentsLoaded(payments: $payments)';
}


}

/// @nodoc
abstract mixin class _$PaymentsLoadedCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
  factory _$PaymentsLoadedCopyWith(_PaymentsLoaded value, $Res Function(_PaymentsLoaded) _then) = __$PaymentsLoadedCopyWithImpl;
@useResult
$Res call({
 List<PaymentData> payments
});




}
/// @nodoc
class __$PaymentsLoadedCopyWithImpl<$Res>
    implements _$PaymentsLoadedCopyWith<$Res> {
  __$PaymentsLoadedCopyWithImpl(this._self, this._then);

  final _PaymentsLoaded _self;
  final $Res Function(_PaymentsLoaded) _then;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payments = null,}) {
  return _then(_PaymentsLoaded(
payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<PaymentData>,
  ));
}


}

/// @nodoc


class _PaymentSettled implements PaymentSettlementState {
  const _PaymentSettled({required this.response});
  

 final  PaymentSettleResponse response;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentSettledCopyWith<_PaymentSettled> get copyWith => __$PaymentSettledCopyWithImpl<_PaymentSettled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentSettled&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'PaymentSettlementState.paymentSettled(response: $response)';
}


}

/// @nodoc
abstract mixin class _$PaymentSettledCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
  factory _$PaymentSettledCopyWith(_PaymentSettled value, $Res Function(_PaymentSettled) _then) = __$PaymentSettledCopyWithImpl;
@useResult
$Res call({
 PaymentSettleResponse response
});




}
/// @nodoc
class __$PaymentSettledCopyWithImpl<$Res>
    implements _$PaymentSettledCopyWith<$Res> {
  __$PaymentSettledCopyWithImpl(this._self, this._then);

  final _PaymentSettled _self;
  final $Res Function(_PaymentSettled) _then;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_PaymentSettled(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as PaymentSettleResponse,
  ));
}


}

/// @nodoc


class _Failure implements PaymentSettlementState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of PaymentSettlementState
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
  return 'PaymentSettlementState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
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

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

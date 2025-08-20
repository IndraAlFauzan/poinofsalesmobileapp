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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FetchPayments value)?  fetchPayments,TResult Function( _SettlePayment value)?  settlePayment,TResult Function( _PollPaymentStatus value)?  pollPaymentStatus,TResult Function( _RetryPayment value)?  retryPayment,TResult Function( _CancelPayment value)?  cancelPayment,TResult Function( _StopPolling value)?  stopPolling,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchPayments() when fetchPayments != null:
return fetchPayments(_that);case _SettlePayment() when settlePayment != null:
return settlePayment(_that);case _PollPaymentStatus() when pollPaymentStatus != null:
return pollPaymentStatus(_that);case _RetryPayment() when retryPayment != null:
return retryPayment(_that);case _CancelPayment() when cancelPayment != null:
return cancelPayment(_that);case _StopPolling() when stopPolling != null:
return stopPolling(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FetchPayments value)  fetchPayments,required TResult Function( _SettlePayment value)  settlePayment,required TResult Function( _PollPaymentStatus value)  pollPaymentStatus,required TResult Function( _RetryPayment value)  retryPayment,required TResult Function( _CancelPayment value)  cancelPayment,required TResult Function( _StopPolling value)  stopPolling,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FetchPayments():
return fetchPayments(_that);case _SettlePayment():
return settlePayment(_that);case _PollPaymentStatus():
return pollPaymentStatus(_that);case _RetryPayment():
return retryPayment(_that);case _CancelPayment():
return cancelPayment(_that);case _StopPolling():
return stopPolling(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FetchPayments value)?  fetchPayments,TResult? Function( _SettlePayment value)?  settlePayment,TResult? Function( _PollPaymentStatus value)?  pollPaymentStatus,TResult? Function( _RetryPayment value)?  retryPayment,TResult? Function( _CancelPayment value)?  cancelPayment,TResult? Function( _StopPolling value)?  stopPolling,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchPayments() when fetchPayments != null:
return fetchPayments(_that);case _SettlePayment() when settlePayment != null:
return settlePayment(_that);case _PollPaymentStatus() when pollPaymentStatus != null:
return pollPaymentStatus(_that);case _RetryPayment() when retryPayment != null:
return retryPayment(_that);case _CancelPayment() when cancelPayment != null:
return cancelPayment(_that);case _StopPolling() when stopPolling != null:
return stopPolling(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  fetchPayments,TResult Function( PaymentSettleRequest request)?  settlePayment,TResult Function( int paymentId)?  pollPaymentStatus,TResult Function( int paymentId)?  retryPayment,TResult Function( int paymentId)?  cancelPayment,TResult Function()?  stopPolling,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchPayments() when fetchPayments != null:
return fetchPayments();case _SettlePayment() when settlePayment != null:
return settlePayment(_that.request);case _PollPaymentStatus() when pollPaymentStatus != null:
return pollPaymentStatus(_that.paymentId);case _RetryPayment() when retryPayment != null:
return retryPayment(_that.paymentId);case _CancelPayment() when cancelPayment != null:
return cancelPayment(_that.paymentId);case _StopPolling() when stopPolling != null:
return stopPolling();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  fetchPayments,required TResult Function( PaymentSettleRequest request)  settlePayment,required TResult Function( int paymentId)  pollPaymentStatus,required TResult Function( int paymentId)  retryPayment,required TResult Function( int paymentId)  cancelPayment,required TResult Function()  stopPolling,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FetchPayments():
return fetchPayments();case _SettlePayment():
return settlePayment(_that.request);case _PollPaymentStatus():
return pollPaymentStatus(_that.paymentId);case _RetryPayment():
return retryPayment(_that.paymentId);case _CancelPayment():
return cancelPayment(_that.paymentId);case _StopPolling():
return stopPolling();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  fetchPayments,TResult? Function( PaymentSettleRequest request)?  settlePayment,TResult? Function( int paymentId)?  pollPaymentStatus,TResult? Function( int paymentId)?  retryPayment,TResult? Function( int paymentId)?  cancelPayment,TResult? Function()?  stopPolling,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchPayments() when fetchPayments != null:
return fetchPayments();case _SettlePayment() when settlePayment != null:
return settlePayment(_that.request);case _PollPaymentStatus() when pollPaymentStatus != null:
return pollPaymentStatus(_that.paymentId);case _RetryPayment() when retryPayment != null:
return retryPayment(_that.paymentId);case _CancelPayment() when cancelPayment != null:
return cancelPayment(_that.paymentId);case _StopPolling() when stopPolling != null:
return stopPolling();case _:
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


class _PollPaymentStatus implements PaymentSettlementEvent {
  const _PollPaymentStatus({required this.paymentId});
  

 final  int paymentId;

/// Create a copy of PaymentSettlementEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PollPaymentStatusCopyWith<_PollPaymentStatus> get copyWith => __$PollPaymentStatusCopyWithImpl<_PollPaymentStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PollPaymentStatus&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId);

@override
String toString() {
  return 'PaymentSettlementEvent.pollPaymentStatus(paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class _$PollPaymentStatusCopyWith<$Res> implements $PaymentSettlementEventCopyWith<$Res> {
  factory _$PollPaymentStatusCopyWith(_PollPaymentStatus value, $Res Function(_PollPaymentStatus) _then) = __$PollPaymentStatusCopyWithImpl;
@useResult
$Res call({
 int paymentId
});




}
/// @nodoc
class __$PollPaymentStatusCopyWithImpl<$Res>
    implements _$PollPaymentStatusCopyWith<$Res> {
  __$PollPaymentStatusCopyWithImpl(this._self, this._then);

  final _PollPaymentStatus _self;
  final $Res Function(_PollPaymentStatus) _then;

/// Create a copy of PaymentSettlementEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentId = null,}) {
  return _then(_PollPaymentStatus(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _RetryPayment implements PaymentSettlementEvent {
  const _RetryPayment({required this.paymentId});
  

 final  int paymentId;

/// Create a copy of PaymentSettlementEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryPaymentCopyWith<_RetryPayment> get copyWith => __$RetryPaymentCopyWithImpl<_RetryPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryPayment&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId);

@override
String toString() {
  return 'PaymentSettlementEvent.retryPayment(paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class _$RetryPaymentCopyWith<$Res> implements $PaymentSettlementEventCopyWith<$Res> {
  factory _$RetryPaymentCopyWith(_RetryPayment value, $Res Function(_RetryPayment) _then) = __$RetryPaymentCopyWithImpl;
@useResult
$Res call({
 int paymentId
});




}
/// @nodoc
class __$RetryPaymentCopyWithImpl<$Res>
    implements _$RetryPaymentCopyWith<$Res> {
  __$RetryPaymentCopyWithImpl(this._self, this._then);

  final _RetryPayment _self;
  final $Res Function(_RetryPayment) _then;

/// Create a copy of PaymentSettlementEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentId = null,}) {
  return _then(_RetryPayment(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _CancelPayment implements PaymentSettlementEvent {
  const _CancelPayment({required this.paymentId});
  

 final  int paymentId;

/// Create a copy of PaymentSettlementEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelPaymentCopyWith<_CancelPayment> get copyWith => __$CancelPaymentCopyWithImpl<_CancelPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelPayment&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId);

@override
String toString() {
  return 'PaymentSettlementEvent.cancelPayment(paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class _$CancelPaymentCopyWith<$Res> implements $PaymentSettlementEventCopyWith<$Res> {
  factory _$CancelPaymentCopyWith(_CancelPayment value, $Res Function(_CancelPayment) _then) = __$CancelPaymentCopyWithImpl;
@useResult
$Res call({
 int paymentId
});




}
/// @nodoc
class __$CancelPaymentCopyWithImpl<$Res>
    implements _$CancelPaymentCopyWith<$Res> {
  __$CancelPaymentCopyWithImpl(this._self, this._then);

  final _CancelPayment _self;
  final $Res Function(_CancelPayment) _then;

/// Create a copy of PaymentSettlementEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentId = null,}) {
  return _then(_CancelPayment(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StopPolling implements PaymentSettlementEvent {
  const _StopPolling();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StopPolling);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentSettlementEvent.stopPolling()';
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _PaymentsLoaded value)?  paymentsLoaded,TResult Function( _PaymentSettled value)?  paymentSettled,TResult Function( _PaymentPolling value)?  paymentPolling,TResult Function( _PaymentCompleted value)?  paymentCompleted,TResult Function( _PaymentFailed value)?  paymentFailed,TResult Function( _PaymentExpired value)?  paymentExpired,TResult Function( _PaymentRetried value)?  paymentRetried,TResult Function( _PaymentCancelled value)?  paymentCancelled,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _PaymentsLoaded() when paymentsLoaded != null:
return paymentsLoaded(_that);case _PaymentSettled() when paymentSettled != null:
return paymentSettled(_that);case _PaymentPolling() when paymentPolling != null:
return paymentPolling(_that);case _PaymentCompleted() when paymentCompleted != null:
return paymentCompleted(_that);case _PaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case _PaymentExpired() when paymentExpired != null:
return paymentExpired(_that);case _PaymentRetried() when paymentRetried != null:
return paymentRetried(_that);case _PaymentCancelled() when paymentCancelled != null:
return paymentCancelled(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _PaymentsLoaded value)  paymentsLoaded,required TResult Function( _PaymentSettled value)  paymentSettled,required TResult Function( _PaymentPolling value)  paymentPolling,required TResult Function( _PaymentCompleted value)  paymentCompleted,required TResult Function( _PaymentFailed value)  paymentFailed,required TResult Function( _PaymentExpired value)  paymentExpired,required TResult Function( _PaymentRetried value)  paymentRetried,required TResult Function( _PaymentCancelled value)  paymentCancelled,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _PaymentsLoaded():
return paymentsLoaded(_that);case _PaymentSettled():
return paymentSettled(_that);case _PaymentPolling():
return paymentPolling(_that);case _PaymentCompleted():
return paymentCompleted(_that);case _PaymentFailed():
return paymentFailed(_that);case _PaymentExpired():
return paymentExpired(_that);case _PaymentRetried():
return paymentRetried(_that);case _PaymentCancelled():
return paymentCancelled(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _PaymentsLoaded value)?  paymentsLoaded,TResult? Function( _PaymentSettled value)?  paymentSettled,TResult? Function( _PaymentPolling value)?  paymentPolling,TResult? Function( _PaymentCompleted value)?  paymentCompleted,TResult? Function( _PaymentFailed value)?  paymentFailed,TResult? Function( _PaymentExpired value)?  paymentExpired,TResult? Function( _PaymentRetried value)?  paymentRetried,TResult? Function( _PaymentCancelled value)?  paymentCancelled,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _PaymentsLoaded() when paymentsLoaded != null:
return paymentsLoaded(_that);case _PaymentSettled() when paymentSettled != null:
return paymentSettled(_that);case _PaymentPolling() when paymentPolling != null:
return paymentPolling(_that);case _PaymentCompleted() when paymentCompleted != null:
return paymentCompleted(_that);case _PaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case _PaymentExpired() when paymentExpired != null:
return paymentExpired(_that);case _PaymentRetried() when paymentRetried != null:
return paymentRetried(_that);case _PaymentCancelled() when paymentCancelled != null:
return paymentCancelled(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<PaymentData> payments)?  paymentsLoaded,TResult Function( PaymentSettleResponse response)?  paymentSettled,TResult Function( PaymentData payment)?  paymentPolling,TResult Function( PaymentData payment)?  paymentCompleted,TResult Function( PaymentData payment,  String reason)?  paymentFailed,TResult Function( PaymentData payment)?  paymentExpired,TResult Function( PaymentRetryResponse response)?  paymentRetried,TResult Function( PaymentCancelResponse response)?  paymentCancelled,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _PaymentsLoaded() when paymentsLoaded != null:
return paymentsLoaded(_that.payments);case _PaymentSettled() when paymentSettled != null:
return paymentSettled(_that.response);case _PaymentPolling() when paymentPolling != null:
return paymentPolling(_that.payment);case _PaymentCompleted() when paymentCompleted != null:
return paymentCompleted(_that.payment);case _PaymentFailed() when paymentFailed != null:
return paymentFailed(_that.payment,_that.reason);case _PaymentExpired() when paymentExpired != null:
return paymentExpired(_that.payment);case _PaymentRetried() when paymentRetried != null:
return paymentRetried(_that.response);case _PaymentCancelled() when paymentCancelled != null:
return paymentCancelled(_that.response);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<PaymentData> payments)  paymentsLoaded,required TResult Function( PaymentSettleResponse response)  paymentSettled,required TResult Function( PaymentData payment)  paymentPolling,required TResult Function( PaymentData payment)  paymentCompleted,required TResult Function( PaymentData payment,  String reason)  paymentFailed,required TResult Function( PaymentData payment)  paymentExpired,required TResult Function( PaymentRetryResponse response)  paymentRetried,required TResult Function( PaymentCancelResponse response)  paymentCancelled,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _PaymentsLoaded():
return paymentsLoaded(_that.payments);case _PaymentSettled():
return paymentSettled(_that.response);case _PaymentPolling():
return paymentPolling(_that.payment);case _PaymentCompleted():
return paymentCompleted(_that.payment);case _PaymentFailed():
return paymentFailed(_that.payment,_that.reason);case _PaymentExpired():
return paymentExpired(_that.payment);case _PaymentRetried():
return paymentRetried(_that.response);case _PaymentCancelled():
return paymentCancelled(_that.response);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<PaymentData> payments)?  paymentsLoaded,TResult? Function( PaymentSettleResponse response)?  paymentSettled,TResult? Function( PaymentData payment)?  paymentPolling,TResult? Function( PaymentData payment)?  paymentCompleted,TResult? Function( PaymentData payment,  String reason)?  paymentFailed,TResult? Function( PaymentData payment)?  paymentExpired,TResult? Function( PaymentRetryResponse response)?  paymentRetried,TResult? Function( PaymentCancelResponse response)?  paymentCancelled,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _PaymentsLoaded() when paymentsLoaded != null:
return paymentsLoaded(_that.payments);case _PaymentSettled() when paymentSettled != null:
return paymentSettled(_that.response);case _PaymentPolling() when paymentPolling != null:
return paymentPolling(_that.payment);case _PaymentCompleted() when paymentCompleted != null:
return paymentCompleted(_that.payment);case _PaymentFailed() when paymentFailed != null:
return paymentFailed(_that.payment,_that.reason);case _PaymentExpired() when paymentExpired != null:
return paymentExpired(_that.payment);case _PaymentRetried() when paymentRetried != null:
return paymentRetried(_that.response);case _PaymentCancelled() when paymentCancelled != null:
return paymentCancelled(_that.response);case _Failure() when failure != null:
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


class _PaymentPolling implements PaymentSettlementState {
  const _PaymentPolling({required this.payment});
  

 final  PaymentData payment;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentPollingCopyWith<_PaymentPolling> get copyWith => __$PaymentPollingCopyWithImpl<_PaymentPolling>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentPolling&&(identical(other.payment, payment) || other.payment == payment));
}


@override
int get hashCode => Object.hash(runtimeType,payment);

@override
String toString() {
  return 'PaymentSettlementState.paymentPolling(payment: $payment)';
}


}

/// @nodoc
abstract mixin class _$PaymentPollingCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
  factory _$PaymentPollingCopyWith(_PaymentPolling value, $Res Function(_PaymentPolling) _then) = __$PaymentPollingCopyWithImpl;
@useResult
$Res call({
 PaymentData payment
});




}
/// @nodoc
class __$PaymentPollingCopyWithImpl<$Res>
    implements _$PaymentPollingCopyWith<$Res> {
  __$PaymentPollingCopyWithImpl(this._self, this._then);

  final _PaymentPolling _self;
  final $Res Function(_PaymentPolling) _then;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payment = null,}) {
  return _then(_PaymentPolling(
payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentData,
  ));
}


}

/// @nodoc


class _PaymentCompleted implements PaymentSettlementState {
  const _PaymentCompleted({required this.payment});
  

 final  PaymentData payment;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCompletedCopyWith<_PaymentCompleted> get copyWith => __$PaymentCompletedCopyWithImpl<_PaymentCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentCompleted&&(identical(other.payment, payment) || other.payment == payment));
}


@override
int get hashCode => Object.hash(runtimeType,payment);

@override
String toString() {
  return 'PaymentSettlementState.paymentCompleted(payment: $payment)';
}


}

/// @nodoc
abstract mixin class _$PaymentCompletedCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
  factory _$PaymentCompletedCopyWith(_PaymentCompleted value, $Res Function(_PaymentCompleted) _then) = __$PaymentCompletedCopyWithImpl;
@useResult
$Res call({
 PaymentData payment
});




}
/// @nodoc
class __$PaymentCompletedCopyWithImpl<$Res>
    implements _$PaymentCompletedCopyWith<$Res> {
  __$PaymentCompletedCopyWithImpl(this._self, this._then);

  final _PaymentCompleted _self;
  final $Res Function(_PaymentCompleted) _then;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payment = null,}) {
  return _then(_PaymentCompleted(
payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentData,
  ));
}


}

/// @nodoc


class _PaymentFailed implements PaymentSettlementState {
  const _PaymentFailed({required this.payment, required this.reason});
  

 final  PaymentData payment;
 final  String reason;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentFailedCopyWith<_PaymentFailed> get copyWith => __$PaymentFailedCopyWithImpl<_PaymentFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentFailed&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,payment,reason);

@override
String toString() {
  return 'PaymentSettlementState.paymentFailed(payment: $payment, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$PaymentFailedCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
  factory _$PaymentFailedCopyWith(_PaymentFailed value, $Res Function(_PaymentFailed) _then) = __$PaymentFailedCopyWithImpl;
@useResult
$Res call({
 PaymentData payment, String reason
});




}
/// @nodoc
class __$PaymentFailedCopyWithImpl<$Res>
    implements _$PaymentFailedCopyWith<$Res> {
  __$PaymentFailedCopyWithImpl(this._self, this._then);

  final _PaymentFailed _self;
  final $Res Function(_PaymentFailed) _then;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payment = null,Object? reason = null,}) {
  return _then(_PaymentFailed(
payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentData,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PaymentExpired implements PaymentSettlementState {
  const _PaymentExpired({required this.payment});
  

 final  PaymentData payment;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentExpiredCopyWith<_PaymentExpired> get copyWith => __$PaymentExpiredCopyWithImpl<_PaymentExpired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentExpired&&(identical(other.payment, payment) || other.payment == payment));
}


@override
int get hashCode => Object.hash(runtimeType,payment);

@override
String toString() {
  return 'PaymentSettlementState.paymentExpired(payment: $payment)';
}


}

/// @nodoc
abstract mixin class _$PaymentExpiredCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
  factory _$PaymentExpiredCopyWith(_PaymentExpired value, $Res Function(_PaymentExpired) _then) = __$PaymentExpiredCopyWithImpl;
@useResult
$Res call({
 PaymentData payment
});




}
/// @nodoc
class __$PaymentExpiredCopyWithImpl<$Res>
    implements _$PaymentExpiredCopyWith<$Res> {
  __$PaymentExpiredCopyWithImpl(this._self, this._then);

  final _PaymentExpired _self;
  final $Res Function(_PaymentExpired) _then;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payment = null,}) {
  return _then(_PaymentExpired(
payment: null == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentData,
  ));
}


}

/// @nodoc


class _PaymentRetried implements PaymentSettlementState {
  const _PaymentRetried({required this.response});
  

 final  PaymentRetryResponse response;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentRetriedCopyWith<_PaymentRetried> get copyWith => __$PaymentRetriedCopyWithImpl<_PaymentRetried>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentRetried&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'PaymentSettlementState.paymentRetried(response: $response)';
}


}

/// @nodoc
abstract mixin class _$PaymentRetriedCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
  factory _$PaymentRetriedCopyWith(_PaymentRetried value, $Res Function(_PaymentRetried) _then) = __$PaymentRetriedCopyWithImpl;
@useResult
$Res call({
 PaymentRetryResponse response
});




}
/// @nodoc
class __$PaymentRetriedCopyWithImpl<$Res>
    implements _$PaymentRetriedCopyWith<$Res> {
  __$PaymentRetriedCopyWithImpl(this._self, this._then);

  final _PaymentRetried _self;
  final $Res Function(_PaymentRetried) _then;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_PaymentRetried(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as PaymentRetryResponse,
  ));
}


}

/// @nodoc


class _PaymentCancelled implements PaymentSettlementState {
  const _PaymentCancelled({required this.response});
  

 final  PaymentCancelResponse response;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCancelledCopyWith<_PaymentCancelled> get copyWith => __$PaymentCancelledCopyWithImpl<_PaymentCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentCancelled&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'PaymentSettlementState.paymentCancelled(response: $response)';
}


}

/// @nodoc
abstract mixin class _$PaymentCancelledCopyWith<$Res> implements $PaymentSettlementStateCopyWith<$Res> {
  factory _$PaymentCancelledCopyWith(_PaymentCancelled value, $Res Function(_PaymentCancelled) _then) = __$PaymentCancelledCopyWithImpl;
@useResult
$Res call({
 PaymentCancelResponse response
});




}
/// @nodoc
class __$PaymentCancelledCopyWithImpl<$Res>
    implements _$PaymentCancelledCopyWith<$Res> {
  __$PaymentCancelledCopyWithImpl(this._self, this._then);

  final _PaymentCancelled _self;
  final $Res Function(_PaymentCancelled) _then;

/// Create a copy of PaymentSettlementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_PaymentCancelled(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as PaymentCancelResponse,
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

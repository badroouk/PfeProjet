// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'arduino_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ArduinoData {
  int? get temperature => throw _privateConstructorUsedError;
  int? get humidity => throw _privateConstructorUsedError;
  int? get uv => throw _privateConstructorUsedError;
  int? get precip => throw _privateConstructorUsedError;
  int? get luminisity => throw _privateConstructorUsedError;
  int? get carbon => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArduinoDataCopyWith<ArduinoData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArduinoDataCopyWith<$Res> {
  factory $ArduinoDataCopyWith(
          ArduinoData value, $Res Function(ArduinoData) then) =
      _$ArduinoDataCopyWithImpl<$Res>;
  $Res call(
      {int? temperature,
      int? humidity,
      int? uv,
      int? precip,
      int? luminisity,
      int? carbon,
      String? date});
}

/// @nodoc
class _$ArduinoDataCopyWithImpl<$Res> implements $ArduinoDataCopyWith<$Res> {
  _$ArduinoDataCopyWithImpl(this._value, this._then);

  final ArduinoData _value;
  // ignore: unused_field
  final $Res Function(ArduinoData) _then;

  @override
  $Res call({
    Object? temperature = freezed,
    Object? humidity = freezed,
    Object? uv = freezed,
    Object? precip = freezed,
    Object? luminisity = freezed,
    Object? carbon = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      temperature: temperature == freezed
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as int?,
      humidity: humidity == freezed
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int?,
      uv: uv == freezed
          ? _value.uv
          : uv // ignore: cast_nullable_to_non_nullable
              as int?,
      precip: precip == freezed
          ? _value.precip
          : precip // ignore: cast_nullable_to_non_nullable
              as int?,
      luminisity: luminisity == freezed
          ? _value.luminisity
          : luminisity // ignore: cast_nullable_to_non_nullable
              as int?,
      carbon: carbon == freezed
          ? _value.carbon
          : carbon // ignore: cast_nullable_to_non_nullable
              as int?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ArduinoDataCopyWith<$Res>
    implements $ArduinoDataCopyWith<$Res> {
  factory _$$_ArduinoDataCopyWith(
          _$_ArduinoData value, $Res Function(_$_ArduinoData) then) =
      __$$_ArduinoDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? temperature,
      int? humidity,
      int? uv,
      int? precip,
      int? luminisity,
      int? carbon,
      String? date});
}

/// @nodoc
class __$$_ArduinoDataCopyWithImpl<$Res> extends _$ArduinoDataCopyWithImpl<$Res>
    implements _$$_ArduinoDataCopyWith<$Res> {
  __$$_ArduinoDataCopyWithImpl(
      _$_ArduinoData _value, $Res Function(_$_ArduinoData) _then)
      : super(_value, (v) => _then(v as _$_ArduinoData));

  @override
  _$_ArduinoData get _value => super._value as _$_ArduinoData;

  @override
  $Res call({
    Object? temperature = freezed,
    Object? humidity = freezed,
    Object? uv = freezed,
    Object? precip = freezed,
    Object? luminisity = freezed,
    Object? carbon = freezed,
    Object? date = freezed,
  }) {
    return _then(_$_ArduinoData(
      temperature: temperature == freezed
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as int?,
      humidity: humidity == freezed
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int?,
      uv: uv == freezed
          ? _value.uv
          : uv // ignore: cast_nullable_to_non_nullable
              as int?,
      precip: precip == freezed
          ? _value.precip
          : precip // ignore: cast_nullable_to_non_nullable
              as int?,
      luminisity: luminisity == freezed
          ? _value.luminisity
          : luminisity // ignore: cast_nullable_to_non_nullable
              as int?,
      carbon: carbon == freezed
          ? _value.carbon
          : carbon // ignore: cast_nullable_to_non_nullable
              as int?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ArduinoData extends _ArduinoData {
  const _$_ArduinoData(
      {this.temperature,
      this.humidity,
      this.uv,
      this.precip,
      this.luminisity,
      this.carbon,
      this.date})
      : super._();

  @override
  final int? temperature;
  @override
  final int? humidity;
  @override
  final int? uv;
  @override
  final int? precip;
  @override
  final int? luminisity;
  @override
  final int? carbon;
  @override
  final String? date;

  @override
  String toString() {
    return 'ArduinoData(temperature: $temperature, humidity: $humidity, uv: $uv, precip: $precip, luminisity: $luminisity, carbon: $carbon, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArduinoData &&
            const DeepCollectionEquality()
                .equals(other.temperature, temperature) &&
            const DeepCollectionEquality().equals(other.humidity, humidity) &&
            const DeepCollectionEquality().equals(other.uv, uv) &&
            const DeepCollectionEquality().equals(other.precip, precip) &&
            const DeepCollectionEquality()
                .equals(other.luminisity, luminisity) &&
            const DeepCollectionEquality().equals(other.carbon, carbon) &&
            const DeepCollectionEquality().equals(other.date, date));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(temperature),
      const DeepCollectionEquality().hash(humidity),
      const DeepCollectionEquality().hash(uv),
      const DeepCollectionEquality().hash(precip),
      const DeepCollectionEquality().hash(luminisity),
      const DeepCollectionEquality().hash(carbon),
      const DeepCollectionEquality().hash(date));

  @JsonKey(ignore: true)
  @override
  _$$_ArduinoDataCopyWith<_$_ArduinoData> get copyWith =>
      __$$_ArduinoDataCopyWithImpl<_$_ArduinoData>(this, _$identity);
}

abstract class _ArduinoData extends ArduinoData {
  const factory _ArduinoData(
      {final int? temperature,
      final int? humidity,
      final int? uv,
      final int? precip,
      final int? luminisity,
      final int? carbon,
      final String? date}) = _$_ArduinoData;
  const _ArduinoData._() : super._();

  @override
  int? get temperature => throw _privateConstructorUsedError;
  @override
  int? get humidity => throw _privateConstructorUsedError;
  @override
  int? get uv => throw _privateConstructorUsedError;
  @override
  int? get precip => throw _privateConstructorUsedError;
  @override
  int? get luminisity => throw _privateConstructorUsedError;
  @override
  int? get carbon => throw _privateConstructorUsedError;
  @override
  String? get date => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ArduinoDataCopyWith<_$_ArduinoData> get copyWith =>
      throw _privateConstructorUsedError;
}

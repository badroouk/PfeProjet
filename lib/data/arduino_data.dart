import 'package:freezed_annotation/freezed_annotation.dart';

part 'arduino_data.freezed.dart';

@freezed
class ArduinoData with _$ArduinoData {
  const ArduinoData._();

  const factory ArduinoData({
    int? temperature,
    int? humidity,
    int? uv,
    int? precip,
    int? luminisity,
    int? carbon,
    String? date,
  }) = _ArduinoData;

// factory Person.fromJson(Map<String, Object?> json)
// => _$PersonFromJson(json);
}

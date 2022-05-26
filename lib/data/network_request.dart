import 'package:arduinopfe/data/arduino_data.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class NetworkRequest {
  late MySqlConnection _connection;
  late Future<MySqlConnection> _connectionFuture;

  NetworkRequest() {
    _connectionFuture = MySqlConnection.connect(
      ConnectionSettings(
          host: '192.168.56.1',
          port: 3306,
          user: 'badr',
          password: 'password',
          db: 'iot'),
    );
  }

  Future<bool> init() async {
    _connection = await _connectionFuture;
    return true;
  }

  Future<void> close() async {
    await _connection.close();
  }

  Future<ArduinoData> retrieveData({
    String? query,
    bool temperature = true,
    bool humidity = true,
    bool ultraviolet = true,
    bool precipitation = true,
    bool luminosity = true,
    bool carbonmonoxide = true,
    bool created_at = true,
  }) async {
    final String queryToExecute = _buildQuery(
        temperature: temperature,
        carbonmonoxide: carbonmonoxide,
        created_at: created_at,
        humidity: humidity,
        luminosity: luminosity,
        precipitation: precipitation,
        ultraviolet: ultraviolet);
    Results data = await _connection.query(
      query ?? queryToExecute,
    );
    final int? temp = data.first.fields['temperature'] != null
        ? (data.first.fields['temperature'] as num).toInt()
        : null;
    final String? time = data.first.fields['created_at'] != null
        ? data.first.fields['created_at'].toString().substring(0, 19)
        : null;
    final int? humi = data.first.fields['humidity'] != null
        ? (data.first.fields['humidity'] as num).toInt()
        : null;
    final int? uv = data.first.fields['ultraviolet'] != null
        ? (data.first.fields['ultraviolet'] as num).toInt()
        : null;
    final int? precip = data.first.fields['precipitation'] != null
        ? (data.first.fields['precipitation'] as num).toInt()
        : null;
    final int? lumin = data.first.fields['luminosity'] != null
        ? (data.first.fields['luminosity'] as num).toInt()
        : null;
    final int? carbon = data.first.fields['carbonmonoxide'] != null
        ? (data.first.fields['carbonmonoxide'] as num).toInt()
        : null;
    final returnedData = ArduinoData(
      temperature: temp,
      humidity: humi,
      uv: uv,
      precip: precip,
      luminisity: lumin,
      carbon: carbon,
      date: time,
    );
    return returnedData;
  }

  Future<List<ArduinoData>> retrieveDataList({
    String? query,
    bool temperature = true,
    bool humidity = true,
    bool ultraviolet = true,
    bool precipitation = true,
    bool luminosity = true,
    bool carbonmonoxide = true,
    bool created_at = true,
  }) async {
    final String queryToExecute = _buildQuery(
        temperature: temperature,
        carbonmonoxide: carbonmonoxide,
        created_at: created_at,
        humidity: humidity,
        luminosity: luminosity,
        precipitation: precipitation,
        ultraviolet: ultraviolet);
    Results data = await _connection.query(
      query ?? queryToExecute,
    );
    List<ArduinoData> listData = [];

    data.toList().forEach((element) {
      final int? temp = element.fields['temperature'] != null
          ? (element.fields['temperature'] as num).toInt()
          : null;
      final String? time = element.fields['created_at'] != null
          ? element.fields['created_at'].toString().substring(0, 19)
          : null;
      final int? humi = element.fields['humidity'] != null
          ? (element.fields['humidity'] as num).toInt()
          : null;
      final int? uv = element.fields['ultraviolet'] != null
          ? (element.fields['ultraviolet'] as num).toInt()
          : null;
      final int? precip = element.fields['precipitation'] != null
          ? (element.fields['precipitation'] as num).toInt()
          : null;
      final int? lumin = element.fields['luminosity'] != null
          ? (element.fields['luminosity'] as num).toInt()
          : null;
      final int? carbon = element.fields['carbonmonoxide'] != null
          ? (element.fields['carbonmonoxide'] as num).toInt()
          : null;
      final returnedData = ArduinoData(
        temperature: temp,
        humidity: humi,
        uv: uv,
        precip: precip,
        luminisity: lumin,
        carbon: carbon,
        date: time,
      );
      listData.add(returnedData);
    });

    return listData;
  }

  String _buildQuery({
    DateTime? dateStart,
    DateTime? dateEnd,
    bool temperature = true,
    bool humidity = true,
    bool ultraviolet = true,
    bool precipitation = true,
    bool luminosity = true,
    bool carbonmonoxide = true,
    bool created_at = true,
  }) {
    final List<String> fields = [];
    if (temperature) fields.add("temperature");
    if (humidity) fields.add("humidity");
    if (ultraviolet) fields.add(" ultraviolet");
    if (precipitation) fields.add("precipitation");
    if (luminosity) fields.add("luminosity");
    if (carbonmonoxide) fields.add("carbonmonoxide");
    if (created_at) fields.add("created_at");
    final String query1 =
        "SELECT ${fields.isEmpty ? "*" : _mapFields(fields)}, `created_at` FROM `arduino` WHERE arduino.created_at BETWEEN \"$dateStart\" AND \"$dateEnd\";";

    final String query2 =
        "SELECT ${fields.isEmpty ? "*" : _mapFields(fields)} FROM `arduino` ORDER BY arduino.id DESC LIMIT 1;";
    if (dateStart != null && dateEnd != null)
      return query1;
    else
      return query2;
  }

  String _mapFields(List<String> fields) {
    String data = "";
    for (String p in fields) {
      if (p == fields.last)
        data += " $p";
      else
        data += " $p,";
    }
    return data;
  }

  String buildTimeRangeQuery({
    required DateTime dateStart,
    required DateTime dateEnd,
    bool temperature = true,
    bool humidity = true,
    bool ultraviolet = true,
    bool precipitation = true,
    bool luminosity = true,
    bool carbonmonoxide = true,
    bool created_at = true,
  }) {
    return _buildQuery(
      dateEnd: dateEnd,
      dateStart: dateStart,
      temperature: temperature,
      humidity: humidity,
      ultraviolet: ultraviolet,
      precipitation: precipitation,
      luminosity: luminosity,
      created_at: created_at,
      carbonmonoxide: carbonmonoxide,
    );
  }
}

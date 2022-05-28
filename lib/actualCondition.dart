import 'package:arduinopfe/reusable_card.dart';
import 'package:arduinopfe/widgets.dart';
import 'package:flutter/material.dart';
import 'data/arduino_data.dart';
import 'data/network_request.dart';

class ActualCondition extends StatelessWidget {
  String getVarData(String variable, ArduinoData data) {
    switch (variable) {
      case "temperature":
        if (data.temperature! >= 26) {
          return data.temperature!.toString() + '°C ' + 'Hot';
        }
        if (data.temperature! <= 25 && data.temperature! >= 15) {
          return data.temperature!.toString() + '°C ' + 'Normal';
        }
        if (data.temperature! < 14) {
          return data.temperature!.toString() + '°C ' + 'Cold';
        }
        break;
      case "humidity":
        if (data.humidity! >= 0 && data.humidity! <= 20) {
          return data.humidity!.toString() + '% ' 'Dry';
        }
        if (data.humidity! > 20 && data.humidity! <= 60) {
          return data.humidity!.toString() + '% ' 'Comfortable';
        }
        if (data.humidity! >= 61) {
          return data.humidity!.toString() + '% ' + 'Wet';
        }
        break;
      case "precipitation":
        if (data.precip! >= 1) {
          return 'Yes';
        } else {
          return 'No';
        }
      case "ultraviolet":
        if (data.uv! < 50) return '0';
        if (data.uv! > 50 && data.uv! <= 227) return 'Low';
        if (data.uv! > 227 && data.uv! <= 318) return 'Low';
        if (data.uv! > 318 && data.uv! <= 408) return 'Low';
        if (data.uv! > 408 && data.uv! <= 503) return 'Moderate';
        if (data.uv! > 503 && data.uv! <= 606) return 'Moderate';
        if (data.uv! > 606 && data.uv! <= 696) return 'Moderate';
        if (data.uv! > 696 && data.uv! <= 795) return 'High';
        if (data.uv! > 795 && data.uv! <= 881) return 'High';
        if (data.uv! > 881 && data.uv! <= 976) return 'Very high';
        if (data.uv! > 976 && data.uv! <= 1079) return 'Very high';
        if (data.uv! > 1079 && data.uv! <= 1170) return 'Very high';
        if (data.uv! > 1170) return 'Extreme';
        break;
      case "luminosity":
        if (data.luminisity! >= 800) return 'Sunny';
        if (data.luminisity! >= 400 && data.luminisity! < 800) return 'Bright';
        if (data.luminisity! >= 100 && data.luminisity! < 400) return 'Dim';
        if (data.luminisity! < 100) return 'Dark';
        break;
      case "carbonmonoxide":
        if (data.carbon! >= 0 && data.carbon! <= 50) {
          return data.carbon!.toString() + 'ppm Good';
        }
        if (data.carbon! >= 51 && data.carbon! <= 100) {
          return data.carbon!.toString() + 'ppm Medium';
        }
        if (data.carbon! >= 101 && data.carbon! <= 199) {
          return data.carbon!.toString() + 'ppm Unhealthy';
        }
        if (data.carbon! >= 200 && data.carbon! <= 299) {
          return data.carbon!.toString() + 'ppm Very unhealthy';
        }
        if (data.carbon! > 300) return data.carbon!.toString() + 'ppm Harmful';
        break;
      case 'created_at':
        return data.date!;
    }
    return 'null';
  }

  final NetworkRequest _networkRequest = NetworkRequest();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _networkRequest.init(),
      builder: (_, snapConnection) {
        if (snapConnection.ready) {
          return FutureBuilder<List<ArduinoData>>(
            future: _networkRequest.retrieveDataList(),
            builder: (_, snapData) {
              if (snapData.hasData) {
                final List<ArduinoData> data = snapData.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableCard(
                      cardChild: Column(children: [
                        Text('Date:'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('${getVarData('created_at', data.first)}'),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReusableCard(
                          cardChild: Column(
                            children: [
                              Text(
                                'Temperature: ',
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  '${getVarData('temperature', data.first)}'),
                            ],
                          ),
                        ),
                        ReusableCard(
                          cardChild: Column(children: [
                            Text(
                              'Humidity: ',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('${getVarData('humidity', data.first)}'),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReusableCard(
                          cardChild: Column(children: [
                            Text(
                              'Precipitation:',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                '${getVarData('precipitation', data.first)}'),
                          ]),
                        ),
                        ReusableCard(
                          cardChild: Column(children: [
                            Text(
                              'Ultraviolet:',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('${getVarData('ultraviolet', data.first)}'),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReusableCard(
                          cardChild: Column(children: [
                            Text(
                              'Luminosity:',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('${getVarData('luminosity', data.first)}'),
                          ]),
                        ),
                        ReusableCard(
                          cardChild: Column(children: [
                            Text(
                              'Pollution:',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                '${getVarData('carbonmonoxide', data.first)}'),
                          ]),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loading(message: "Retrieving data ...").center(),
                      ],
                    ).center()
                  ],
                );
              }
            },
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: loading(message: "Connecting to mysql ...").center(),
              )
            ],
          );
        }
      },
    );
  }
}

extension FutureExtension on AsyncSnapshot {
  bool get ready => hasData && connectionState == ConnectionState.done;
}

extension WidgetExtensions on Widget {
  Widget center() {
    return Center(
      child: this,
    );
  }
}

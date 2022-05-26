import 'package:flutter/material.dart';

import '../data/arduino_data.dart';
import '../data/network_request.dart';
import '../widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class backupDataPage extends StatelessWidget {
  late final String? queryToExecute;
  late final DateTime dateStart;
  late final DateTime dateEnd;
  late final String variable;

  int getVarData(String variable, ArduinoData data) {
    switch (variable) {
      case "temperature":
        return data.temperature!;
      case "humidity":
        return data.humidity!;
      case "precipitation":
        return data.precip!;
      case "ultraviolet":
        return data.uv!;
      case "luminosity":
        return data.luminisity!;
      case "carbonmonoxide":
        return data.carbon!;
      default:
        return data.temperature!;
    }
  }

  backupDataPage(
      {required this.queryToExecute,
      required this.dateStart,
      required this.dateEnd,
      required this.variable});

  final NetworkRequest _networkRequest = NetworkRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5E4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text('Back-up data'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/forest.jpg'), fit: BoxFit.cover),
        ),
        child: FutureBuilder<bool>(
          future: _networkRequest.init(),
          builder: (_, snapConnection) {
            if (snapConnection.ready) {
              return FutureBuilder<List<ArduinoData>>(
                future: _networkRequest.retrieveDataList(query: queryToExecute),
                builder: (_, snapData) {
                  if (snapData.hasData) {
                    final List<ArduinoData> data = snapData.data!;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: 380,
                            height: 300,
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
// Enable legend
                                legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.bottom),

// Enable tooltip
                                tooltipBehavior: TooltipBehavior(enable: true),
                                title: ChartTitle(
                                    text:
                                        "${variable.toUpperCase()} between ${dateStart.toString().substring(0, 10)} and ${dateEnd.toString().substring(0, 10)}"),
                                enableAxisAnimation: true,
                                series: <ChartSeries<ArduinoData, String>>[
                                  LineSeries<ArduinoData, String>(
                                    color: Color(0xFFFF6363),
                                    dataSource: data,
                                    xValueMapper: (ArduinoData temp, _) =>
                                        temp.date!.substring(10, 19),
                                    yValueMapper: (ArduinoData temp, _) =>
                                        getVarData(variable, temp),
                                    name: '$variable',
// Enable data label
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      showCumulativeValues: true,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            height: 300,
                            width: 380,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                loading(message: "Retrieving data ...")
                                    .center(),
                              ],
                            )).center()
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
        ),
      ),
    );
  }
}

extension FutureExtension on AsyncSnapshot {
  bool get ready => hasData && connectionState == ConnectionState.done;
}

extension DuplicateRemoval<T> on List<T> {
  List<T> get removeAllDuplicates => [
        ...{...this}
      ];
}

extension WidgetExtensions on Widget {
  Widget center() {
    return Center(
      child: this,
    );
  }
}

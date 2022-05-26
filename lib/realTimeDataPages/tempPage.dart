import 'package:arduinopfe/data/arduino_data.dart';
import 'package:arduinopfe/data/network_request.dart';
import 'package:arduinopfe/refresh_stream.dart';
import 'package:arduinopfe/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class tempPage extends StatefulWidget {
  @override
  State<tempPage> createState() => _tempPageState();
}

class _tempPageState extends State<tempPage> {
  final NetworkRequest _networkRequest = NetworkRequest();
  static List<ArduinoData> data2 = [];
  RefreshStream<ArduinoData> _refreshStream =
      RefreshStream(Duration(seconds: 3) /**/);

  @override
  void dispose() {
    _refreshStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5E4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF9D5353),
        title: Text('Temperature data'),
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
      body: FutureBuilder<bool>(
        future: _networkRequest.init(),
        builder: (_, snapConnection) {
          if (snapConnection.ready) {
            return StreamBuilder<ArduinoData>(
              stream: _refreshStream.call(() => _networkRequest.retrieveData()),
              builder: (_, snapData) {
                if (snapData.hasData) {
                  final dataToAdd = snapData.data!;
                  if (!data2.contains(dataToAdd)) data2.add(dataToAdd);

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
                              title: ChartTitle(text: "Temp data"),
                              enableAxisAnimation: true,
                              series: <ChartSeries<ArduinoData, String>>[
                                LineSeries<ArduinoData, String>(
                                  color: Color(0xFFFF6363),
                                  dataSource: data2,
                                  xValueMapper: (ArduinoData temp, _) =>
                                      temp.date,
                                  yValueMapper: (ArduinoData temp, _) =>
                                      temp.temperature,
                                  name: 'Temperature',
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
                              loading(message: "Retrieving data ...").center(),
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

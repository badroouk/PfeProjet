import 'package:arduinopfe/refresh_stream2.dart';
import 'package:arduinopfe/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class humidityPage extends StatefulWidget {
  @override
  State<humidityPage> createState() => _humidityPageState();
}

class _humidityPageState extends State<humidityPage> {
  RefreshStream2<List<_humidityData>> _refreshStream = RefreshStream2(Duration(seconds: 2));

  Future<MySqlConnection> _retrieveConnection() async {
    return MySqlConnection.connect(
      ConnectionSettings(
          host: '192.168.1.6',
          port: 3306,
          user: 'badr',
          password: 'password',
          db: 'iot'),
    );
  }

  Future<List<_humidityData>> _retrieveData(MySqlConnection connection) async {
    Results carbon = await connection.query(
      "SELECT * FROM `arduino` ORDER BY arduino.id DESC LIMIT 1;",
    );
    final humidity = carbon.first.fields['humidity'].toString();
    final time =  carbon.first.fields['created_at'].toString();
    debugPrint("data=$humidity , created=$time");
    List<_humidityData> data;
    return data= [
      _humidityData(humidity, time),
    ];
  }

  @override
  void dispose() {
    _refreshStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006E7F),
        title: Text('Humidity data'),
      ),
      body: FutureBuilder<MySqlConnection>(
        future: _retrieveConnection(),
        builder: (_, snapConnection) {
          if (snapConnection.ready) {
            final MySqlConnection connection = snapConnection.data!;
            return FutureBuilder(
                future: _refreshStream.call(() => _retrieveData(connection)),
                builder: (context, snap) {
                  return StreamBuilder<List<_humidityData>>(
                    stream: _refreshStream.stream,
                    builder: (_, snapData) {
                      if (snapData.hasData) {
                        final List<_humidityData> data = snapData.data!;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child:  SfCartesianChart(
                                  backgroundColor: Colors.white,
                                  primaryXAxis: CategoryAxis(),
// Enable legend
                                  legend: Legend(isVisible: true, position: LegendPosition.bottom),

// Enable tooltip
                                  tooltipBehavior: TooltipBehavior(enable: true),
                                  series: <ChartSeries<_humidityData, String>>[
                                    LineSeries<_humidityData, String>(
                                        color: Color(0xFFFF6363),
                                        dataSource: data,
                                        xValueMapper: (_humidityData sales, _) => sales.time,
                                        yValueMapper: (_humidityData sales, _) => double.parse(sales.humidity),
                                        name: 'Temperature',
// Enable data label
                                        dataLabelSettings: DataLabelSettings(isVisible: true))
                                  ]),
                            ),


                          ],

                        );
                      } else {
                        return Column(
                          children: [
                            loading(message: "Retrieving data ...").center(),
                          ],
                        );
                      }
                    },
                  );
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading(message: "Connecting to mysql ...").center(),
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

class _humidityData {
  _humidityData(this.humidity, this.time);

  final String time;
  final String humidity;
}

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
  static int x = 1;
  static List<_humidityData> data2 = [];
  RefreshStream2<List<_humidityData>> _refreshStream =
      RefreshStream2(Duration(seconds: 4));

  Future<MySqlConnection> _retrieveConnection() async {
    return MySqlConnection.connect(
      ConnectionSettings(
          host: '192.168.56.1',
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
    final time = carbon.first.fields['created_at'].toString().substring(10,19);

    List<_humidityData> data;
    return data = [
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
      backgroundColor: Color(0xFFFAF5E4),
      appBar:  AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF9D5353),
        title: Text('humidity data'),
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
                        data2.add(snapData.data!.first);
                        var seen = Set<String>();
                        List<_humidityData> uniquelist = data2.where((data) => seen.add(data._time)).toList();
                        print(uniquelist.length);
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
                                    legend: Legend(
                                        isVisible: true,
                                        position: LegendPosition.bottom),

// Enable tooltip
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    series: <ChartSeries<_humidityData, String>>[
                                      LineSeries<_humidityData, String>(
                                          color: Color(0xFFFF6363),
                                          dataSource: uniquelist,
                                          xValueMapper:
                                              (_humidityData humidity, _) =>
                                                  humidity._time,
                                          yValueMapper:
                                              (_humidityData humidity,_) =>
                                              double.parse(humidity._humidity),
                                          name: 'Humidity',
// Enable data label
                                          dataLabelSettings:
                                              DataLabelSettings(isVisible: true))
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
                                child : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    loading(message: "Retrieving data ...").center(),
                                  ],
                                )
                            ).center()
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

  List<_humidityData> _Listener(_humidityData data) {
    final newData = new _humidityData(data._humidity, data._time);
    final List<_humidityData> myList = [];
    myList.add(newData);
    print(myList.length);
    return myList;
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


class _humidityData {
  _humidityData(this._humidity, this._time);

  final String _time;
  final String _humidity;

  set _time(String value) {
    _time = value;
  }

  set _humidity(String value) {
    _humidity = value;
  }
}

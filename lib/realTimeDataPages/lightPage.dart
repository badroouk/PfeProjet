import 'package:arduinopfe/refresh_stream2.dart';
import 'package:arduinopfe/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LightPage extends StatefulWidget {
  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  static int x = 1;
  static List<_LightData> data2 = [];
  RefreshStream2<List<_LightData>> _refreshStream =
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

  Future<List<_LightData>> _retrieveData(MySqlConnection connection) async {
    Results carbon = await connection.query(
      "SELECT * FROM `arduino` ORDER BY arduino.id DESC LIMIT 1;",
    );
    final Light = carbon.first.fields['luminosity'].toString();
    final time = carbon.first.fields['created_at'].toString().substring(10,19);

    List<_LightData> data;
    return data = [
      _LightData(Light, time),
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
        title: Text('luminosity data'),
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
                  return StreamBuilder<List<_LightData>>(
                    stream: _refreshStream.stream,
                    builder: (_, snapData) {
                      if (snapData.hasData) {
                        data2.add(snapData.data!.first);
                        var seen = Set<String>();
                        List<_LightData> uniquelist = data2.where((data) => seen.add(data._time)).toList();
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
                                    series: <ChartSeries<_LightData, String>>[
                                      LineSeries<_LightData, String>(
                                          color: Color(0xFFFF6363),
                                          dataSource: uniquelist,
                                          xValueMapper:
                                              (_LightData Light, _) =>
                                              Light._time,
                                          yValueMapper:
                                              (_LightData Light,_) =>
                                              double.parse(Light._Light),
                                          name: 'Light',
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

  List<_LightData> _Listener(_LightData data) {
    final newData = new _LightData(data._Light, data._time);
    final List<_LightData> myList = [];
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


class _LightData {
  _LightData(this._Light, this._time);

  final String _time;
  final String _Light;

  set _time(String value) {
    _time = value;
  }

  set _Light(String value) {
    _Light = value;
  }
}

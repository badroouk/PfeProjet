import 'package:arduinopfe/refresh_stream.dart';
import 'package:arduinopfe/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class LightPage extends StatefulWidget {
  @override
  State<LightPage> createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  RefreshStream<String>? _refreshStream;
  final Duration _refreshInterval = Duration(seconds: 2);

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

  Future<String> _retrieveData(MySqlConnection connection) async {
    Results carbon = await connection.query(
      "SELECT arduino.luminosity FROM `arduino` ORDER BY arduino.id DESC LIMIT 1;",
    );
    final data = carbon.first.fields['luminosity'].toString();
    debugPrint("data=$data");
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006E7F),
        title: Text('Light data'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<MySqlConnection>(
              future: _retrieveConnection(),
              builder: (_, snapConnection) {
                if (snapConnection.hasData &&
                    snapConnection.connectionState == ConnectionState.done) {
                  final MySqlConnection connection = snapConnection.data!;
                  _refreshStream = RefreshStream(
                    _refreshInterval,
                  );
                  return StreamBuilder<String>(
                    stream: _refreshStream!(() => _retrieveData(connection)),
                    initialData: "0",
                    builder: (_, snapData) {
                      if (snapData.hasData) {
                        final data = snapData.data!;
                        debugPrint("data=$data");
                        return Text(
                          data.toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        );
                      } else {
                        return loading(message: "Retrieving data..");
                      }
                    },
                  );
                } else {
                  return loading(message: "Connecting to mysql..");
                }
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_refreshStream != null) _refreshStream!.close();
    super.dispose();
  }
}

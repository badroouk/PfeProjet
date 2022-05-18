import 'package:mysql1/mysql1.dart';

class mysql {
  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: '192.168.1.6',
        port: 3306,
        user: 'badr',
        password: 'password',
        db: 'iot');
    return await MySqlConnection.connect(settings);
  }
}

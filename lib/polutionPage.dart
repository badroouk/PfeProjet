import 'package:arduinopfe/database/mysql.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class polPage extends StatefulWidget {
  const polPage({Key? key}) : super(key: key);

  @override
  State<polPage> createState() => _polPageState();
}

class _polPageState extends State<polPage> with SingleTickerProviderStateMixin {
  var res;
  var carbon;
  var row;
  Future getConnection() async {
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
          host: '192.168.0.135',
          port: 3306,
          user: 'reda',
          password: 'password',
          db: 'iot'),
    );
    res = await conn.query(
        'SELECT `carbonmonoxide` FROM `arduino` WHERE id=(SELECT max(id) FROM `arduino`);');
    for (row in res) {
      setState(() {
        carbon = row[0];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006E7F),
        title: Text('Polution data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: getConnection,
              child: Text('click me'),
            ),
            Text('$carbon'),
          ],
        ),
      ),
    );
  }
}

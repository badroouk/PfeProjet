import 'package:arduinopfe/realTimeDataPages/RealTimeDataMenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql1/mysql1.dart';
import 'package:arduinopfe/database/mysql.dart';

class backUpPage extends StatefulWidget {
  backUpPage({Key? key}) : super(key: key);

  @override
  State<backUpPage> createState() => _backUpPageState();
}

class _backUpPageState extends State<backUpPage> {
  var res;

  List<String> carbon=[];

  var row;

  Future getConnection() async {
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
          host: '192.168.56.1',
          port: 3306,
          user: 'badr',
          password: 'password',
          db: 'iot'),
    );
    res = await conn.query(
        'SELECT * FROM `arduino`;');
    for (row in res) {
        carbon.add(row[7].toString().substring(10, 19));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5E4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF9D5353),
        title: Text('Back-up Data'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: SizedBox(
              width: 200,
              child: menuButton(
                press: (){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                icon:  FontAwesomeIcons.clock,
                text: "Real-Time data",
              ),
            ),
          ),
          SizedBox(height: 30,),
          Center(
            child: SizedBox(
              width: 200,
              child: menuButton(
                press: (){
                  getConnection();
                },
                icon:  FontAwesomeIcons.database,
                text: "Back-Up data",
              ),
            ),
          )
        ],
      ),
    );
  }
}

class menuButton extends StatelessWidget {
  const menuButton({required this.icon,required this.text,required this.press
  }) ;
  final press;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFFFFC069)),
          minimumSize: MaterialStateProperty.all(Size(0, 50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text),
            FaIcon(
                icon
            )
          ],
        ));
  }
}

import 'package:arduinopfe/backUpDataPages/backUpDataMenu.dart';
import 'package:arduinopfe/realTimeDataPages/RealTimeDataMenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class monitoringPage extends StatelessWidget {
  const monitoringPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5E4),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF9D5353),
        title: Text('Monitoring Page'),
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => backUpPage()));
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

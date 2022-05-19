import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class tempPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  tempPage({Key? key}) : super(key: key);

  @override
  _tempPageState createState() => _tempPageState();
}
class _tempPageState extends State<tempPage> {
  final _database = FirebaseDatabase.instance.reference();
  var plz;
  List Pages = [
  ];
  int index = 0;
  void initState() {
    super.initState();
    activateListener();
  }
 void activateListener() async{
    final tempref = await _database.child('Arduino/temperature').get();
    print(tempref.value);
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
      body: Pages[index],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: index,
        onTap: (int newInd) {
          setState(() {
            index = newInd;
          });
        },
        elevation: 0.0,
        selectedItemColor: Color(0xFFB37878),
        backgroundColor: Colors.transparent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.show_chart,
              size: 50,
            ),
            label: 'line',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart,
              size: 50,
            ),
            label: 'bar',
          ),
        ],
      ),
    );
  }
}
void getTemp()async {
 final Temp = await FirebaseFirestore.instance.collection('Temperature').get();
 for (var tmp in Temp.docs ){
   print(tmp.data());
 }
}
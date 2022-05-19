import 'package:flutter/material.dart';
import 'humidityPage.dart';
import 'polutionPage.dart';
import 'waterPage.dart';
import 'lightPage.dart';
import 'botBarPages/tempPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController? controller;
  double? cntrlValue = 0;
  int numb = 10;
  final _key1 = GlobalKey();
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 700),
        lowerBound: 0,
        upperBound: 130);
  }

  @override
  Widget build(BuildContext context) {
    if (controller?.value != null) {
      cntrlValue = controller?.value.toDouble();
    }

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9D5353),
        centerTitle: true,
        title: Text('arduino state '),
      ),
      body: Center(
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            key: _key1,
            color: Color(0xFFFDF6EC),
          ),
          Positioned(
            right: cntrlValue! + (screenSize.width / 3),
            bottom: cntrlValue! + (screenSize.height / 3).toDouble(),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => polPage()));
              },
              child: <Widget>[
                FaIcon(
                  FontAwesomeIcons.smog,
                  color: Color(0xFFFAF5E4),
                ),
                SizedBox(height: 10),
                Text("Polution"),
              ],
              size: BoxConstraints.tightFor(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Positioned(
            right: cntrlValue! + (screenSize.width / 3),
            top: cntrlValue! + (screenSize.height / 3).toDouble(),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LightPage()));
              },
              child: <Widget>[
                FaIcon(
                  FontAwesomeIcons.lightbulb,
                  color: Color(0xFFFAF5E4),
                ),
                SizedBox(height: 10),
                Text("Light"),
              ],
              size: BoxConstraints.tightFor(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Positioned(
            left: cntrlValue! + (screenSize.width / 3),
            top: cntrlValue! + (screenSize.height / 3).toDouble(),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => humidityPage()));
              },
              child: <Widget>[
                FaIcon(
                  FontAwesomeIcons.lightbulb,
                  color: Color(0xFFFAF5E4),
                ),
                SizedBox(height: 10),
                Text("humidity"),
              ],
              size: BoxConstraints.tightFor(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Positioned(
            left: cntrlValue! + (screenSize.width / 3),
            bottom: cntrlValue! + (screenSize.height / 3).toDouble(),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => waterPage()));
              },
              child: <Widget>[
                FaIcon(
                  FontAwesomeIcons.water,
                  color: Color(0xFFFAF5E4),
                ),
                SizedBox(height: 10),
                Text("Water"),
              ],
              size: BoxConstraints.tightFor(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Positioned(
            bottom: cntrlValue! + (screenSize.height /2.6),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => tempPage()));
              },
              child: <Widget>[
                FaIcon(
                  FontAwesomeIcons.temperatureHalf,
                  color: Color(0xFFFAF5E4),
                ),
                SizedBox(height: 10),
                Text("Temp"),
              ],
              size: BoxConstraints.tightFor(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          mainButton(
            press: () {
              if (controller?.status == AnimationStatus.completed) {
                controller?.reverse();
              } else {
                controller?.forward();
              }
              controller?.addListener(() {
                setState(() {});
              });
            },
            child: <Widget>[
              FaIcon(
                FontAwesomeIcons.database,
                size: 40,
                color: Color(0xFFFAF5E4),
              ),
              SizedBox(height: 10),
              Text("Sensors"),
            ],
            size: BoxConstraints.tightFor(
              width: 160.0,
              height: 160.0,
            ),
          ),
        ]),
      ),
    );
  }
}

class mainButton extends StatelessWidget {
  mainButton({required this.press, required this.child, required this.size});
  final press;
  final List<Widget> child;
  final BoxConstraints size;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: child,
      ),
      onPressed: press,
      shape: CircleBorder(),
      fillColor: Color(0xFFFFC069),
      constraints: size,
    );
  }
}

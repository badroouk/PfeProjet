import 'package:flutter/material.dart';
import 'polutionPage.dart';
import 'waterPage.dart';
import 'lightPage.dart';
import 'tempPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController? controller;
  double? x = 0;
  int numb = 10;
  final _key1 = GlobalKey();
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 700),
        lowerBound: 0,
        upperBound: 150);
  }

  @override
  Widget build(BuildContext context) {
    if (controller?.value != null) {
      x = controller?.value.toDouble();
    }

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006E7F),
        centerTitle: true,
        title: Text('arduino state '),
      ),
      body: Center(
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Container(
            key: _key1,
            color: Color(0xFFFAF5E4),
          ),
          Positioned(
            right: x! + (screenSize.width / 3),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => polPage()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.smog,
                    color:  Color(0xFFFAF5E4),
                  ),
                  SizedBox(height: 10),
                  Text("Polution"),
                ],
              ),
              colour: Color(0xFFFF6363),
              size: BoxConstraints.tightFor(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Positioned(
            top: x! + (screenSize.height / 3).toDouble(),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => lightPage()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                      FontAwesomeIcons.lightbulb,
                      color: Color(0xFFFAF5E4),
                  ),
                  SizedBox(height: 10),
                  Text("Light"),
                ],
              ),
              colour: Color(0xFFFF6363),
              size: BoxConstraints.tightFor(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Positioned(
            left: x! + (screenSize.width / 3),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => waterPage()));
              },
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.water,
                    color:  Color(0xFFFAF5E4),
                  ),
                  SizedBox(height: 10),
                  Text("Water"),
                ],
              ),
              colour: Color(0xFFFF6363),
              size: BoxConstraints.tightFor(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Positioned(
            bottom: x! + (screenSize.height / 3),
            child: mainButton(
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => tempPage()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.temperatureHalf,
                    color:  Color(0xFFFAF5E4),
                  ),
                  SizedBox(height: 10),
                  Text("Temp"),
                ],
              ),
              colour: Color(0xFFFF6363),
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
                print(controller?.status);
                setState(() {});
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.database,
                  size: 40,
                  color: Color(0xFFFAF5E4),
                ),
                SizedBox(height: 10),
                Text("Sensors"),
              ],
            ),
            colour: Color(0xFFFF6363),
            size: BoxConstraints.tightFor(
              width: 150.0,
              height: 150.0,
            ),
          ),
        ]),
      ),
    );
  }
}

class mainButton extends StatelessWidget {
  mainButton(
      {required this.press,
      required this.colour,
      required this.child,
      required this.size});
  final press;
  final Color colour;
  final Widget child;
  final BoxConstraints size;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: child,
      onPressed: press,
      shape: CircleBorder(),
      fillColor: colour,
      constraints: size,
    );
  }
}

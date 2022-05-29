import 'package:arduinopfe/actualCondition.dart';
import 'package:arduinopfe/authentification/login_page.dart';
import 'package:arduinopfe/statistics/dataMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arduinopfe/reusable_card.dart';

import 'MonitoringMenu.dart';

class pageAcceuil extends StatelessWidget {
  const pageAcceuil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5E4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFF9D5353),
        title: Text('Arduino weather station'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              SharedPreferences localstorage =
                  await SharedPreferences.getInstance();
              localstorage.remove('user');
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => loginPage()));

              // do something
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 5),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ActualCondition(),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      child: Stack(children: [
                        ReusableCard(
                          color: Color(0xFFFFC069),
                          cardChild: SvgPicture.asset(
                            "images/actualcon.svg",
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Actuall conditions info"),
                                        content: Text("Somthing"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("ok"))
                                        ],
                                      ));
                            },
                            color: Colors.black,
                            icon: Icon(
                              Icons.info_outline,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.bottomCenter,
                          child: Text("Actuall Conditions"),
                        )
                      ]),
                    )),
              ),
              SizedBox(width: 5),
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => monitoringPage()));
                      },
                      child: Container(
                        height: 200,
                        child: Stack(children: [
                          ReusableCard(
                            color: Color(0xFFFFC069),
                            cardChild: SvgPicture.asset(
                              "images/Monitoring.svg",
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.bottomCenter,
                            child: Text("Monitoring"),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Monitoring info"),
                                          content: Text("Somthing"),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("ok"))
                                          ],
                                        ));
                              },
                              color: Colors.black,
                              icon: Icon(
                                Icons.info_outline,
                              ),
                            ),
                          ),
                        ]),
                      ))),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => dataPage()));
              },
              child: Container(
                height: 200,
                child: Stack(children: [
                  ReusableCard(
                    color: Color(0xFFFFC069),
                    cardChild: SvgPicture.asset(
                      "images/statistics.svg",
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Statistics info"),
                                  content: Text("Somthing"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("ok"))
                                  ],
                                ));
                      },
                      color: Colors.black,
                      icon: Icon(
                        Icons.info_outline,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomCenter,
                    child: Text("Statistics"),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

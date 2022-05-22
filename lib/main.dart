import 'package:flutter/material.dart';
import 'authentification/login_page.dart';
import 'authentification/register_page.dart';
import 'pageAcceuil.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:registerPage(),
    );
  }
}



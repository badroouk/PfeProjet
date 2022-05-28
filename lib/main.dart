import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentification/login_page.dart';
import 'pageAcceuil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}
class _MyApp extends State<MyApp>{
  bool _islogged = false;
  @override
  void initState(){
    _checkIfLogged();
    super.initState();
  }
  void _checkIfLogged()async{
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    var user = localstorage.getString('user');
    debugPrint("user is = $user");
    if(user != null){
       this.setState(() {
         _islogged = true;
       });
    }
    print(_islogged);
    }

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home:Scaffold(
        body:_islogged ? pageAcceuil() : loginPage(),
      ),// Scaffold
    );
    // MaterialApp
  }
}
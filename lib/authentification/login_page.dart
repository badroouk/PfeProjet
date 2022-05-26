import 'dart:convert';
import 'package:arduinopfe/realTimeDataPages/RealTimeDataMenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:arduinopfe/authentification/register_page.dart';
import 'package:arduinopfe/pageAcceuil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _validate = false;
  bool _validate2 = false;
  bool _isObscure = true;


  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async{
    var url = Uri.parse("http://192.168.56.1/login_register/login.php");
    var response = await http.post(url,body : {
      "username" : user.text,
      "password" : pass.text,
    });
    var data = response.body;
    print(data);
    if (data == "\"Success\"") {
      Fluttertoast.showToast(
          msg: "successfuly loged in",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.9);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => pageAcceuil()));
    }else{
      Fluttertoast.showToast(
          msg: "user undefined",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.9);
    }

  }
  @override
  Widget build(BuildContext context) {
    final iskeyboard=MediaQuery.of(context).viewInsets.bottom!=0;
    return KeyboardDismissOnTap(
      child: Scaffold(
          resizeToAvoidBottomInset : true,
          backgroundColor: Color(0xFFFAF5E4),
          body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome Back!",
              style: TextStyle(
              fontSize: 30,
            ),),
            SizedBox(height: 10,),
            Text("log in in ur existing account of arduino app",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey
              ),),
            if (!iskeyboard) Container(
              width: 300,
              height: 200,
              child: SvgPicture.asset("images/hello.svg")
            ),
            SizedBox(height:20),
            TextField(
              controller: user,
              decoration: InputDecoration(
                errorText: _validate2 ? 'Value Can\'t Be Empty' : null,
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                labelText: 'UserName',
                labelStyle: TextStyle(
                    color: Colors.black
                ),
                prefixIcon: Icon(Icons.person,color : Color(0xFFFFC069)),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color(0xFFFFC069), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color(0xFFFFC069), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color(0xFF9D5353), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:
                  BorderSide(color:Color(0xFF9D5353), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType:  TextInputType.text,
              controller: pass,
              obscureText: _isObscure,
              decoration: InputDecoration(
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: Colors.black
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFFFFC069) ,),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                prefixIcon: Icon(Icons.lock,color:Color(0xFFFFC069) ,),
                prefixIconColor: Color(0xFFFFC069),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color(0xFFFFC069), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                errorBorder:OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color(0xFF9D5353), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color(0xFF9D5353), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Color(0xFFFFC069), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Color(0xFFFFC069),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      if(user.text.isEmpty && pass.text.isEmpty){
                        _validate2 = true;
                        _validate = true;
                      }else if(pass.text.isEmpty){
                        _validate = true;
                      }
                      else if (user.text.isEmpty) {
                        _validate2 = true;
                      }
                      else{
                        _validate = false;
                        _validate2=false;
                        login();
                      }
                    });
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'u dont have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                    text: 'register',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  recognizer: TapGestureRecognizer()..onTap = (){
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => registerPage()));
                  }

                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}

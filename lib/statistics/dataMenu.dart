import 'dart:convert';
import 'package:arduinopfe/backUpDataPages/backupDataPage.dart';
import 'package:http/http.dart ' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql1/mysql1.dart';

class dataPage extends StatefulWidget {
  dataPage({Key? key}) : super(key: key);

  @override
  State<dataPage> createState() => _dataPageState();
}

class _dataPageState extends State<dataPage> {
  String final_response = "";
  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  late String _dropdownValue = 'temperature';
  late DateTime _dateStart = DateTime.now();
  late DateTime _dateEnd = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5E4),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                DropdownButtonFormField(
                  dropdownColor: Color(0xFFFFC069),
                  decoration: const InputDecoration(
                    constraints: BoxConstraints.tightFor(width: 250,height: 60),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFFC069),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFFFFC069),
                        ),
                      )),
                  hint: Text("select value"),
                  items: const [
                    DropdownMenuItem(
                      child: Text('temperature'),
                      value: 'temperature',
                    ),
                    DropdownMenuItem(
                      child: Text('humidity'),
                      value: 'humidity',
                    ),
                    DropdownMenuItem(
                      child: Text('precipitation'),
                      value: 'precipitation',
                    ),
                    DropdownMenuItem(
                      child: Text('ultraviolet'),
                      value: 'ultraviolet',
                    ),
                    DropdownMenuItem(
                      child: Text('luminosity'),
                      value: 'luminosity',
                    ),
                    DropdownMenuItem(
                      child: Text('Pollution'),
                      value: 'carbonmonoxide',
                    ),
                  ],
                  onChanged: dropdownCallback,
                  value: _dropdownValue,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFFFFC069)),
                  onPressed: () async {
                    DateTime? dateStart = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2222),
                    );
                    if (dateStart == null) return;

                    debugPrint(
                        'date start: ${dateStart.toString().substring(0, 10)}');

                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 00, minute: 00),
                    );
                    if (newTime == null) return;
                    final newDateTimeStart = DateTime(
                        dateStart.year,
                        dateStart.month,
                        dateStart.day,
                        newTime.hour,
                        newTime.minute);
                    setState(() {
                      _dateStart = newDateTimeStart;
                    });
                  },
                  child: Text('Select Start date'),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFFFFC069)),
                  onPressed: () async {
                    DateTime? dateEnd = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2222),
                    );
                    if (dateEnd == null) return;

                    debugPrint(
                        'date end: ${dateEnd.toString().substring(0, 19)}');

                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 00, minute: 00),
                    );
                    if (newTime == null) return;
                    debugPrint(newTime.toString());
                    final newDateTimeEnd = DateTime(dateEnd.year, dateEnd.month,
                        dateEnd.day, newTime.hour, newTime.minute);
                    setState(() {
                      _dateEnd = newDateTimeEnd;
                    });
                  },
                  child: Text('select End date'),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary:Color(0xFF9D5353)),
                    onPressed: () async {
                      dropdownCallback(_dropdownValue);
                      final url = "http://192.168.1.6:5000/";
                      final response = await http.post(Uri.parse(url),
                          body: json.encode({
                            'value': _dropdownValue,
                            'date_start':
                                _dateStart.toString().substring(0, 19),
                            'date_end': _dateEnd.toString().substring(0, 19)
                          }));
                    },
                    child: Text('proceed to calculations'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFFFFC069)),
                      onPressed: () async {
                        final url = "http://192.168.1.6:5000/";
                        final response = await http.get(Uri.parse(url));
                        final decode =
                            json.decode(response.body) as Map<String, dynamic>;
                        setState(() {
                          final_response =
                              "Mean = ${decode['cursormean'].toString()}";
                        });
                      },
                      child: Text('calcul mean'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFFFFC069)),
                      onPressed: () async {
                        final url = "http://192.168.1.6:5000/";
                        final response = await http.get(Uri.parse(url));
                        final decode =
                            json.decode(response.body) as Map<String, dynamic>;
                        setState(() {
                          final_response =
                              "Mode = ${decode['cursormode'].toString()}";
                        });
                      },
                      child: Text('calcul mode'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFFFFC069)),
                      onPressed: () async {
                        final url = "http://192.168.1.6:5000/";
                        final response = await http.get(Uri.parse(url));
                        final decode =
                            json.decode(response.body) as Map<String, dynamic>;
                        setState(() {
                          final_response =
                              "Variance =${decode['cursorvar'].toString()}";
                          debugPrint("value = $final_response");
                        });
                      },
                      child: Text('calcul variance'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFFFFC069)),
                      onPressed: () async {
                        final url = "http://192.168.1.6:5000/";
                        final response = await http.get(Uri.parse(url));
                        final decode =
                            json.decode(response.body) as Map<String, dynamic>;
                        setState(() {
                          final_response =
                              "Median =${decode['cursormed'].toString()}";
                        });
                      },
                      child: Text('calcul Median'),
                    ),
                  ],
                ),
                Text(final_response),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class menuButton extends StatelessWidget {
  const menuButton(
      {required this.icon, required this.text, required this.press});
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
          children: [Text(text), FaIcon(icon)],
        ));
  }
}

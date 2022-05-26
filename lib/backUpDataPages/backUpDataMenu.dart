import 'package:arduinopfe/backUpDataPages/backupDataPage.dart';
import 'package:arduinopfe/realTimeDataPages/RealTimeDataMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql1/mysql1.dart';

class backUpPage extends StatefulWidget {
  backUpPage({Key? key}) : super(key: key);

  @override
  State<backUpPage> createState() => _backUpPageState();
}

class _backUpPageState extends State<backUpPage> {
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text('Back-up Data'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/forest.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  DropdownButton(
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
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
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
                        debugPrint(newTime.toString());
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
                      child: Text(
                          'Start date: ${_dateStart.toString().substring(0, 19)}'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
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
                        final newDateTimeEnd = DateTime(
                            dateEnd.year,
                            dateEnd.month,
                            dateEnd.day,
                            newTime.hour,
                            newTime.minute);
                        setState(() {
                          _dateEnd = newDateTimeEnd;
                        });
                      },
                      child: Text(
                          'End date: ${_dateEnd.toString().substring(0, 19)}'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => backupDataPage(
                                      queryToExecute:
                                          "SELECT `$_dropdownValue`,`created_at` FROM `arduino` WHERE arduino.created_at BETWEEN \"$_dateStart\"  AND \"$_dateEnd\";",
                                      dateStart: _dateStart,
                                      dateEnd: _dateEnd,
                                      variable: _dropdownValue,
                                    )));
                      },
                      child: Text('Search'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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

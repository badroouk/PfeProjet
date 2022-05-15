import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class showChart extends StatelessWidget {
  showChart({Key? key}) : super(key: key);
  final List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5E4),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Container(
            height: 40,
            width: 1000,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              toggleButton(
                child: Text("this Day", style: TextStyle(
                  color: Color(0xFFFAF5E4),
                ),),
              ),
              SizedBox(width: 20),
              toggleButton(
                child: Text("this Week"),
              ),
              SizedBox(width: 20),
              toggleButton(
                child: Text("this Month"),
              ),
              SizedBox(width: 20),
            ]),
          ),
          SizedBox(height: 20),
//Initialize the chart widget
          SfCartesianChart(
              backgroundColor: Colors.white,
              primaryXAxis: CategoryAxis(),
// Enable legend
              legend: Legend(isVisible: true, position: LegendPosition.bottom),

// Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    color: Color(0xFFFF6363),
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Temperature',
// Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
          SizedBox(height: 30),
          Text("Table Data")
        ]),
      ),
    );
  }
}

class toggleButton extends StatelessWidget {
  const toggleButton({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFFFFC069)),
          fixedSize: MaterialStateProperty.all(Size(150, 30))),
      onPressed: () {},
      child: child,
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

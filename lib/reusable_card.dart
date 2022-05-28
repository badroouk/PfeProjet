import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Widget cardChild;

  ReusableCard({required this.cardChild});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

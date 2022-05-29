import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Widget cardChild;
  final Color color;

  ReusableCard({required this.cardChild, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        child: cardChild,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

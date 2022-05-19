import 'package:flutter/material.dart';

Widget loading({
  String message = "Loading",
}) {
  return Column(
    children: [
      const CircularProgressIndicator(color: Color(0xFFFFC069)),
      const SizedBox(height: 20),
      Text(message),
    ],
  );
}

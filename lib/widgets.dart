import 'package:flutter/material.dart';

Widget loading({
  String message = "Loading",
}) {
  return Column(
    children: [
      const CircularProgressIndicator(),
      const SizedBox(height: 20),
      Text(message),
    ],
  );
}

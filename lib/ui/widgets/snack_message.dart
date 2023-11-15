import 'package:flutter/material.dart';

void showSnackMessage(BuildContext context, String msg,[bool isError= false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}


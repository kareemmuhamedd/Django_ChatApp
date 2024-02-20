import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, Color clr) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: clr,
    ),
  );
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? text;
  VoidCallback? onTap;

  CustomButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.width * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
          text!,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({super.key, this.text,this.onTap});
  VoidCallback? onTap;
  String? text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kSecondryColor,
        ),
        width: double.infinity,
        height: 40,
        child: Text(
          text ?? "",
          style: const TextStyle(color: kPrimaryColor, fontSize: 20),
        ),
      ),
    );
  }
}

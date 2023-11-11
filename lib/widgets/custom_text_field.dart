import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({
    super.key,
    this.obscure = false,
    this.hintText,
    this.onChanged,
    this.controller,
    this.errorText = "Field Is Requierd",
  });
  Function(String value)? onChanged;
  String? hintText;
  String errorText;
  bool obscure;
  TextEditingController? controller;
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return errorText;
        } else if (pass == false && obscure == true) {
          return "Password is Wrong";
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 14),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kSecondryColor, width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          hintText: hintText ?? "",
          hintStyle: const TextStyle(color: kSecondryColor)),
      style: const TextStyle(color: kSecondryColor),
      obscureText: obscure,
    );
  }
}

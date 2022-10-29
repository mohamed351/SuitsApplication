// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  String? currentLabel = "";
  bool? obscureText = false;
  Widget? icon;
  final Function validator;
  final Function onSave;
  TextInputType? currentKeyBordType = TextInputType.none;
  TextFieldWidget(
      {this.currentLabel,
      this.obscureText,
      this.icon,
      this.currentKeyBordType,
      required this.validator,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(66),
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        keyboardType: currentKeyBordType,
        obscureText: obscureText!,
        validator: (value) => validator(value),
        onSaved: (value) => onSave(value),
        decoration: InputDecoration(
          hintText: currentLabel,
          border: InputBorder.none,
          icon: icon,
        ),
      ),
    );
  }
}

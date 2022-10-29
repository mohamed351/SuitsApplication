import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonWidget extends StatelessWidget {
  VoidCallback submitData;
  bool isLoading;
  Text currentText;
  ButtonWidget(
      {required this.currentText,
      required this.submitData,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: submitData,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 106, vertical: 10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27))),
                ),
                child: currentText),
          );
  }
}

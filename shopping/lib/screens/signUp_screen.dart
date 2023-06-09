// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/signUp.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/screens/auth_screen.dart';
import 'package:shopping/widgets/button_widget.dart';
import 'package:shopping/widgets/text_field_widget.dart';

import '../constaint/constaint.dart';

class SignupScreen extends StatelessWidget {
  static const routerName = "/signUp";
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // ignore: prefer_final_fields
  SignUp _signUp = SignUp(
      pharamceyName: "",
      doctorName: "",
      address: "",
      email: "",
      password: "",
      phoneNumber: "");
  void _submitData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await Provider.of<Auth>(context, listen: false).register(_signUp);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(fontSize: 35),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                            onSave: (String value) {
                              _signUp.pharamceyName = value;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "The Input is not valid";
                              }
                              return null;
                            },
                            icon: Icon(
                              Icons.add_business_rounded,
                              color: Constaint.textPrimaryColor,
                            ),
                            obscureText: false,
                            currentLabel: "Pharmacy Name :"),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            onSave: (value) {
                              _signUp.doctorName = value;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "The Input is not valid";
                              }
                              return null;
                            },
                            icon: Icon(Icons.person,
                                color: Constaint.textPrimaryColor),
                            obscureText: false,
                            currentLabel: "Doctor's Name :"),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            onSave: (value) {
                              _signUp.address = value;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "The Input is not valid";
                              }
                              return null;
                            },
                            icon: Icon(Icons.balance,
                                color: Constaint.textPrimaryColor),
                            obscureText: false,
                            currentLabel: " Address :"),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            onSave: (value) {
                              _signUp.phoneNumber = value;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "The Input is not valid";
                              }
                              return null;
                            },
                            icon: Icon(Icons.whatshot_sharp,
                                color: Constaint.textPrimaryColor),
                            obscureText: false,
                            currentLabel: "Phone :",
                            currentKeyBordType: TextInputType.number),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            onSave: (value) {
                              _signUp.email = value;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "The Input is not valid";
                              }
                              return null;
                            },
                            icon: Icon(Icons.email,
                                color: Constaint.textPrimaryColor),
                            obscureText: false,
                            currentLabel: "Email :",
                            currentKeyBordType: TextInputType.emailAddress),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                          onSave: (value) {
                            this._signUp.password = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "The Input is not valid";
                            }
                            return null;
                          },
                          icon: Icon(Icons.password,
                              color: Constaint.textPrimaryColor),
                          obscureText: true,
                          currentLabel: "Password :",
                          currentKeyBordType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                            currentText: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 20),
                            ),
                            submitData: () => _submitData(context),
                            isLoading: false),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account.  "),
                            TextButton(
                              child: Text("Login"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

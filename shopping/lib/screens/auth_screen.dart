import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/constaint/constaint.dart';
import 'package:shopping/screens/signUp_screen.dart';
import 'package:shopping/widgets/button_widget.dart';
import '../providers/auth_provider.dart';
import '../widgets/text_field_widget.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth";

  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'phone': '',
    'password': '',
  };

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    Provider.of<Auth>(context, listen: false)
        .loginUser(
            _authData["phone"].toString(), _authData["password"].toString())
        .then((value) => {
              setState(() {
                _isLoading = false;
              })
            })
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message),
        duration: Duration(milliseconds: 1500),
      ));
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(fontSize: 35, fontFamily: "myfont"),
                        ),

                        const SizedBox(
                          height: 120,
                        ),
                        TextFieldWidget(
                            currentLabel: "Phone",
                            obscureText: false,
                            icon: const Icon(
                              Icons.phone,
                              color: Constaint.textPrimaryColor,
                            ),
                            onSave: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Phone Number !';
                              }
                              return null;
                            },
                            validator: (value) {
                              _authData['phone'] = value.toString();
                            },
                            currentKeyBordType: TextInputType.phone),
                        // MyTextfield(currentLabel:"Phone", obscureText:false,Icon(Icons.phone)),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                          currentLabel: "Password",
                          obscureText: true,
                          icon: const Icon(Icons.password,
                              color: Constaint.textPrimaryColor),
                          onSave: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Password is too short!';
                            }
                          },
                          validator: (value) {
                            _authData['password'] = value.toString();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                            currentText: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Constaint.textPrimaryColor),
                            ),
                            submitData: _submit,
                            isLoading: _isLoading),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                              child: Text("Sign Up"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SignupScreen.routerName);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

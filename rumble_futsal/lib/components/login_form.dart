import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumble_futsal/components/button.dart';
import 'package:rumble_futsal/main.dart';
import 'package:rumble_futsal/models/auth_model.dart';
import 'package:rumble_futsal/providers/dio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

class LoginForm extends StatefulWidget {
  final Function(String message) showErrorToast;

  const LoginForm({Key? key, required this.showErrorToast}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscurePass = true;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@') || !value.contains('.com')) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
              enabled: true,
            ),
            validator: _validateEmail,
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscurePass,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              enabled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePass = !obscurePass;
                  });
                },
                icon: obscurePass
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black38,
                      )
                    : const Icon(
                        Icons.visibility_rounded,
                        color: Config.primaryColor,
                      ),
              ),
            ),
            validator: _validatePassword,
          ),
          Config.spaceSmall,
          Consumer<AuthModel>(
            builder: (BuildContext context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign In',
                disable: false,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final token = await DioProvider().getToken(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (token != null) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final tokenValue = prefs.getString('token') ?? '';
                        if (tokenValue.isNotEmpty && token != '') {
                          final response =
                              await DioProvider().getUser(tokenValue);
                          if (response != null) {
                            setState(() {
                              Map<String, dynamic> booking = {};
                              final user = json.decode(response);

                              for (var groundData in user['ground']) {
                                if (groundData['bookings'] != null) {
                                  booking = groundData;
                                }
                              }
                              auth.loginSuccess(user, booking);
                              MyApp.navigatorKey.currentState!
                                  .pushNamed('main');
                            });
                          }
                        }
                      }
                    } catch (error) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Failed to login'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

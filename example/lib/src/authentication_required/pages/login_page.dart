/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/authentication_required/pages/login_datasource.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.loginDataSource});

  final LoginDataSource loginDataSource;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: 'Type any things', labelText: 'Username:')),
            const SizedBox(height: 8),
            TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: 'Type any things', labelText: 'Password:')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  await widget.loginDataSource.login(_usernameController.text, _passwordController.text);
                  Navigator.pop(context);
                },
                child: const Text('Login')),
          ],
        ),
      )),
    );
  }
}

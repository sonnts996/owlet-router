/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/authentication_required/authentication_route.dart';
import 'package:example/src/authentication_required/pages/login_datasource.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.loginDataSource});

  final LoginDataSource loginDataSource;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Text.rich(
            TextSpan(text: 'Hello ', children: [
              TextSpan(
                  text: loginDataSource.userData!.username,
                  style: Theme.of(context).textTheme.headlineLarge?.apply(fontWeightDelta: 2)),
              TextSpan(text: ' ;)', style: Theme.of(context).textTheme.headlineLarge?.apply(fontWeightDelta: 2))
            ]),
            style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}

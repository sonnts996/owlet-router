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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Your username:', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(width: 8),
                    Expanded(child: Text(loginDataSource.userData!.username)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('Your password:', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(width: 8),
                    Expanded(child: Text(loginDataSource.userData!.password)),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

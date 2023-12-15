/*
 Created by Thanh Son on 27/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';

import '../../../widgets/leading_icon.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text('Author'),
            centerTitle: false,
            leading: const LeadingIcon()),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: Text(error?.toString() ?? 'Something was wrong!!!')),
        ),
      );
}

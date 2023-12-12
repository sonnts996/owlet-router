/*
 Created by Thanh Son on 01/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:objectx/objectx.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key, this.content = 'TestApp', this.onTab});

  final String content;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) =>
      onTab?.let((it) => Placeholder(
            child: ElevatedButton(
              onPressed: it,
              child: Text(content),
            ),
          )) ??
      Placeholder(
        child: Text(content),
      );
}

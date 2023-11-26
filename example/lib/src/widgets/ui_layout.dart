/*
 Created by Thanh Son on 09/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';

class UILayout extends StatelessWidget {
  const UILayout({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget? child;
  final Widget Function(
      BuildContext context, bool isOnDesktopMode, Widget? child) builder;

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        return builder(
            context, constraints.maxHeight <= constraints.maxWidth, child);
      });
}

/*
 Created by Thanh Son on 28/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';

import '../utilities/utilities.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: isDesktopMode
          ? Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 300, maxWidth: 1000),
                child: child,
              ))
          : child);
}

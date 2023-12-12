/*
 Created by Thanh Son on 09/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';

import '../utilities/utilities.dart';

enum ScreenMode {
  mobile,
  normal;

  bool get isNormal => this == ScreenMode.normal;

  bool get isMobile => this == ScreenMode.mobile;
}

final ValueNotifier<ScreenMode> screenModeNotifier = ValueNotifier(ScreenMode.normal);

class ResponsiveLayoutWatcher extends StatelessWidget {
  const ResponsiveLayoutWatcher({super.key, required this.child});

  final Widget child;

  static const screenLimit = 785; // 2.618 * (drawer size == 300)

  @override
  Widget build(BuildContext context) {
    if (isDesktopMode) {
      return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth <= screenLimit) {
          if (screenModeNotifier.value != ScreenMode.mobile) {
            screenModeNotifier.value = ScreenMode.mobile;
          }
        } else {
          if (screenModeNotifier.value != ScreenMode.normal) {
            screenModeNotifier.value = ScreenMode.normal;
          }
        }
        return child;
      });
    }
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          if (screenModeNotifier.value != ScreenMode.mobile) {
            screenModeNotifier.value = ScreenMode.mobile;
          }
        } else {
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth <= screenLimit) {
              if (screenModeNotifier.value != ScreenMode.mobile) {
                screenModeNotifier.value = ScreenMode.mobile;
              }
            } else {
              if (screenModeNotifier.value != ScreenMode.normal) {
                screenModeNotifier.value = ScreenMode.normal;
              }
            }
            return child;
          });
        }
        return child;
      },
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget? child;
  final Widget Function(BuildContext context, ScreenMode mode, Widget? child) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<ScreenMode>(
        valueListenable: screenModeNotifier,
        child: child,
        builder: builder,
      );
}

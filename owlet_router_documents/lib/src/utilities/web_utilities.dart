/*
 Created by Thanh Son on 28/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'dart:html';

import 'package:flutter/foundation.dart';

final bool mIsDesktopMode = ![TargetPlatform.android, TargetPlatform.iOS].contains(defaultTargetPlatform);

void updateUrlBar(String title, String url) {
  window.history.pushState({}, title, url);
}

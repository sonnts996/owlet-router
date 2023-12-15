/*
 Created by Thanh Son on 28/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter_highlighter/themes/github.dart';
import 'package:google_fonts/google_fonts.dart';

import 'web_utilities.dart'
    if (dart.library.html) 'web_utilities.dart'
    if (dart.library.io) 'io_utilities.dart' as platform;

final bool isDesktopMode = platform.mIsDesktopMode;

final textTheme = GoogleFonts.robotoTextTheme();

final codeTextTheme = GoogleFonts.robotoMono(height: 20, fontSize: 14);

const codeTheme = githubTheme;

String replace(String source, Map<String, String> replacements) {
  var result = source;
  for (var i in replacements.keys) {
    result = result.replaceAll('{$i}', replacements[i]!);
  }
  return result;
}

String getUriExtension(Uri uri) {
  var path = uri.path;
  var dotIndex = path.lastIndexOf('.');
  if (dotIndex >= 0) {
    return path.substring(dotIndex + 1);
  } else {
    return '';
  }
}

void updateUrlBar(String title, String url) {
  platform.updateUrlBar(title, url);
}

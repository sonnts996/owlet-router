/*
 Created by Thanh Son on 28/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:google_fonts/google_fonts.dart';

import 'web_utilities.dart' if (dart.library.html) 'web_utilities.dart' if (dart.library.io) 'io_utilities.dart';

final bool isDesktopMode = mIsDesktopMode;

final textTheme = GoogleFonts.robotoTextTheme();

String replace(String source, Map<String, String> replacements) {
  var result = source;
  for (var i in replacements.keys) {
    result = result.replaceAll('{$i}', replacements[i]!);
  }
  return result;
}

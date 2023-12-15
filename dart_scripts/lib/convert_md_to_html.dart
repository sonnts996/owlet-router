/*
 Created by Thanh Son on 09/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'dart:io';

import 'package:markdown/markdown.dart' as md;

String convertMd2Html(String contents) {
  return md.markdownToHtml(contents);
}

String loadMarkdownContent(File file) {
  print('Load contents from ${file.path}');
  final contents = file.readAsStringSync();
  return contents;
}

void writeMarkdownContent(File file, String contents) {
  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }
  file.writeAsStringSync(contents);
  print('Write contents to ${file.path}');
}

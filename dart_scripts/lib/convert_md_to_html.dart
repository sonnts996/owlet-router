/*
 Created by Thanh Son on 09/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'dart:io';

import 'package:markdown/markdown.dart' as md;
import 'package:path/path.dart' as path;

String convertMd2Html(String contents) {
  return md.markdownToHtml(contents);
}

String loadMarkdownContent(File file) {
  final contents = file.readAsStringSync();
  return contents;
}

void writeMarkdownContent(File file, String contents) {
  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }
  file.writeAsStringSync(contents);
}

void generateHtml(String directory) {
  final originDir = Directory(path.join(path.absolute(directory), 'docs'));
  assert(originDir.existsSync(), '');
  final resultDir = Directory(path.join(path.absolute(directory), 'docs_html'));
  for (var e in originDir.listSync(recursive: true)) {
    if (path.extension(e.path) == 'md') {
      final contents = loadMarkdownContent(File(e.path));
      final htmlContents = convertMd2Html(contents);
      writeMarkdownContent(
        File(path.join(resultDir.path, '${path.basenameWithoutExtension(e.path)}.html')),
        htmlContents,
      );
    }
  }
}

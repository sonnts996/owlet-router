import 'dart:io';

import 'package:dart_scripts/convert_md_to_html.dart';
import 'package:path/path.dart' as path;

void generateHtml(String directory) {
  directory = path.absolute(directory);
  final originDir = Directory(path.join(directory, 'docs'));
  assert(originDir.existsSync(), '');
  final resultDir = Directory(path.join(directory, 'docs_html'));
  final listFile = originDir.listSync(recursive: true);
  for (var e in listFile) {
    if (path.extension(e.path) == '.md') {
      final contents = loadMarkdownContent(File(e.path));
      final htmlContents = convertMd2Html(contents);
      writeMarkdownContent(
        File(path.join(
            resultDir.path, '${path.basenameWithoutExtension(e.path)}.html')),
        htmlContents,
      );
    }
  }
}

import 'dart:io';

import 'package:dart_scripts/convert_md_to_html.dart';
import 'package:path/path.dart' as path;

void main() {
  generateReadmeFile();
}

void generateReadmeFile() {
  final file = File(path.absolute('../owlet_router/README.md'));
  final contents = loadMarkdownContent(file);
  final htmlContents = convertMd2Html(contents);
  writeMarkdownContent(
    File(path.join(path.absolute('../owlet_router/example/documents/home/docs_html'), 'readme.html')),
    htmlContents,
  );
}

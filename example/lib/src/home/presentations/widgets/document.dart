/*
 Created by Thanh Son on 29/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/github.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:objectx/objectx.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher_string.dart';

import '../../../widgets/svg_shield.dart';
import '../../domain/interfaces/metadata_interface.dart';

class Document extends StatelessWidget {
  Document({
    super.key,
    this.docs = const [],
    required this.getContent,
  });

  final List<DocumentMetaDataInterface> docs;
  final Future<String> Function(String file) getContent;

  final codeBuilder = BlockCodeElementBuilder();

  @override
  Widget build(BuildContext context) => ListView.separated(
        itemBuilder: (context, index) {
          final doc = docs[index];
          return FutureBuilder<String>(
              future: getContent(doc.file),
              builder: (context, snapshot) => Markdown(
                    data: (snapshot.data ?? doc.title),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    onTapLink: (text, href, title) {
                      if (href != null) {
                        launchUrlString(href);
                      }
                    },
                    imageBuilder: (uri, title, alt) {
                      final extension = path.extension(uri.path);
                      if (extension == '.svg') {
                        return SvgPicture.network(uri.toString());
                      } else {
                        if (uri.host == 'img.shields.io') {
                          return SvgShield(shieldUrl: uri.toString());
                        }
                        return CachedNetworkImage(imageUrl: uri.toString());
                      }
                    },
                    builders: {
                      'pre': codeBuilder,
                      'code': codeBuilder,
                      'blockquote': BlockQuoteElementBuilder(),
                    },
                    extensionSet: md.ExtensionSet(
                      md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                      <md.InlineSyntax>[md.EmojiSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
                    ),
                    styleSheet: MarkdownStyleSheet(
                      codeblockDecoration: BoxDecoration(
                          color: Color(0xfff8f8f8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5))),
                      codeblockPadding: EdgeInsets.zero,
                      blockquoteDecoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Theme.of(context).colorScheme.primary)),
                      blockSpacing: 16,
                    ),
                  ));
        },
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: docs.length,
      );
}

class BlockCodeElementBuilder extends MarkdownElementBuilder {
  BlockCodeElementBuilder() {
    codeTheme = Map.from(githubTheme);
    codeTheme['root'] = TextStyle(color: Color(0xff333333), backgroundColor: Color(0xffe1e1e1));
  }

  late final Map<String, TextStyle> codeTheme;

  final Set<String> _preCache = {};

  @override
  void visitElementBefore(md.Element element) {
    if (element.tag == 'pre') {
      _preCache.add(element.textContent);
    }
  }

  @override
  Widget? visitElementAfterWithContext(
      BuildContext context, md.Element element, TextStyle? preferredStyle, TextStyle? parentStyle) {
    var language = 'dart';

    if (element.attributes['class'] != null) {
      var lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    var inlineCode = !_preCache.contains(element.textContent);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: HighlightView(
        element.textContent,
        language: language,
        theme: inlineCode ? codeTheme : githubTheme,
        padding: inlineCode
            ? EdgeInsets.symmetric(vertical: 2, horizontal: 4)
            : EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        textStyle: GoogleFonts.robotoMono(),
      ),
    );
  }
}

class BlockQuoteElementBuilder extends MarkdownElementBuilder {
  @override
  void visitElementBefore(md.Element element) {
    (element.textContent).print(tag: 'visitElementBefore');
    super.visitElementBefore(element);
  }

  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    (text.textContent).print(tag: 'visitText');

    return super.visitText(text, preferredStyle);
  }

  @override
  Widget? visitElementAfterWithContext(
      BuildContext context, md.Element element, TextStyle? preferredStyle, TextStyle? parentStyle) {
    (element.textContent).print(tag: 'visitElementAfterWithContext');
    return super.visitElementAfterWithContext(context, element, preferredStyle, parentStyle);
  }
}

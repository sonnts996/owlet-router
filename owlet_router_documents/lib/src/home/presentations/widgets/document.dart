/*
 Created by Thanh Son on 29/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../utilities/utilities.dart';
import '../../domain/interfaces/metadata_interface.dart';

class Document extends StatelessWidget {
  const Document({
    super.key,
    this.docs = const [],
    required this.getContent,
  });

  final List<DocumentMetaDataInterface> docs;
  final Future<String> Function(String file) getContent;

  @override
  Widget build(BuildContext context) => ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: docs.length,
        itemBuilder: (context, index) {
          final doc = docs[index];
          return FutureBuilder<String>(
              future: getContent(doc.file),
              builder: (context, snapshot) => Html(
                    data: snapshot.data ?? doc.title,
                    shrinkWrap: true,
                    onLinkTap: (url, attributes, element) {
                      if (url != null) {
                        launchUrlString(url);
                      }
                    },
                    extensions: [
                      ImageExtension(),
                      TagExtension(
                          tagsToExtend: {'pre'},
                          builder: (extensionContext) => Container(
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xfff8f8f8),
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor)),
                                child: HighlightView(
                                  extensionContext.element?.text.trim() ?? '',
                                  language: 'dart',
                                  theme: codeTheme,
                                  textStyle: codeTextTheme,
                                ),
                              )),
                      TagExtension(
                          tagsToExtend: {'code'},
                          builder: (extensionContext) => Transform.translate(
                                offset: const Offset(0, 1),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: extensionContext
                                              .style?.backgroundColor),
                                      child: Text(
                                          extensionContext.element?.text
                                                  .trim() ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    )),
                              )),
                    ],
                    style: {
                      'a': Style.fromTextStyle(TextStyle(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.none,
                      )),
                      'p > code':
                          Style(backgroundColor: const Color(0xFFe1e1e1)),
                      'p': Style.fromTextStyle(Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(heightDelta: 0.8)),
                    },
                  ));
        },
      );
}

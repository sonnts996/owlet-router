/*
 Created by Thanh Son on 29/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:objectx/objectx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../utilities/utilities.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/svg_shield.dart';

class DocumentScrollToFragment {
  DocumentScrollToFragment(this.scrollController);

  final ScrollController scrollController;
  final HashMap<String, GlobalKey> _keys = HashMap();

  void appendKey(String fragment, GlobalKey key) {
    _keys[fragment] = key;
  }

  void scrollTo(String fragment) {
    assert(fragment.startsWith('#'), 'Fragment must be start with "#". Example: #fragment-to-widget');
    final key = _keys[fragment];
    if (key != null) {
      scrollController.animateTo(widgetPositionOnViewport(key),
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  double widgetPositionOnViewport(GlobalKey key) {
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final gPos = box?.localToGlobal(Offset.zero) ?? Offset.zero;
    return scrollController.position.pixels + gPos.dy - (8 + kToolbarHeight);
  }
}

class Document extends StatefulWidget {
  const Document({
    required this.file,
    required this.getContent,
    required this.documentScrollToFragment,
    required this.controller,
    super.key,
    this.label = '',
  });

  final String file;
  final String label;
  final Future<String> Function(String file) getContent;
  final DocumentScrollToFragment documentScrollToFragment;
  final ScrollController controller;

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  void onClickedLink(String? value) {
    if (value != null && (value.startsWith('http://') || value.startsWith('https://'))) {
      launchUrlString(value);
    } else if (value != null && value.startsWith('#')) {
      widget.documentScrollToFragment.scrollTo(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<String>(
        future: widget.getContent(widget.file),
        builder: (context, snapshot) => SingleChildScrollView(
              controller: widget.controller,
              physics: const ClampingScrollPhysics(),
              child: Html(
                data: snapshot.data ?? widget.label,
                shrinkWrap: true,
                style: {
                  'p > code': Style(backgroundColor: const Color(0xFFe1e1e1)),
                  'p': Style.fromTextStyle(Theme.of(context).textTheme.bodyMedium!.apply(heightDelta: 0.8)),
                },
                extensions: [
                  TagExtension(
                    tagsToExtend: {'h1'},
                    builder: (extensionContext) => AnchorWidget(
                      onClickedLink: onClickedLink,
                      text: extensionContext.element?.text.trim() ?? '',
                      level: 'h1',
                      onGenerateKey: widget.documentScrollToFragment.appendKey,
                    ),
                  ),
                  TagExtension(
                    tagsToExtend: {'h2'},
                    builder: (extensionContext) => AnchorWidget(
                      onClickedLink: onClickedLink,
                      text: extensionContext.element?.text.trim() ?? '',
                      level: 'h2',
                      onGenerateKey: widget.documentScrollToFragment.appendKey,
                    ),
                  ),
                  TagExtension(
                    tagsToExtend: {'h3'},
                    builder: (extensionContext) => AnchorWidget(
                      onClickedLink: onClickedLink,
                      text: extensionContext.element?.text.trim() ?? '',
                      level: 'h3',
                      onGenerateKey: widget.documentScrollToFragment.appendKey,
                    ),
                  ),
                  TagExtension(
                    tagsToExtend: {'a'},
                    builder: (extensionContext) {
                      final href = extensionContext.attributes['href'];
                      if (extensionContext.elementChildren.isNotEmpty) {
                        final element = extensionContext.elementChildren.first;
                        if (element.localName == 'img') {
                          final url = element.attributes['src'];
                          final width = element.attributes['width']?.toDouble();
                          final height = element.attributes['height']?.toDouble();
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: GestureDetector(
                                onTap: () => onClickedLink(href),
                                child: (url?.startsWith('https://img.shields.io') ?? false)
                                    ? SvgShield(shieldUrl: url!)
                                    : ImageWidget(
                                        imageUrl: extensionContext.attributes['src'] ?? '',
                                        width: width,
                                        height: height)),
                          );
                        }
                      }
                      return Text.rich(
                        WidgetSpan(
                            child: TextButton(
                          child: Text(extensionContext.element?.text.trim() ?? ''),
                          onPressed: () => onClickedLink(href),
                        )),
                      );
                    },
                  ),
                  TagWrapExtension(
                    tagsToWrap: {'blockquote'},
                    builder: (child) => Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          border: Border(
                              left: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer, width: 5))),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                      child: child,
                    ),
                  ),
                  TagExtension(
                    tagsToExtend: {'img'},
                    builder: (extensionContext) => ImageWidget(
                      imageUrl: extensionContext.attributes['src'] ?? '',
                      width: extensionContext.attributes['width']?.toDouble(),
                      height: extensionContext.attributes['height']?.toDouble(),
                    ),
                  ),
                  TagExtension(
                      tagsToExtend: {'pre'},
                      builder: (extensionContext) => Container(
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xfff8f8f8),
                                border: Border.all(color: Theme.of(context).dividerColor)),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: extensionContext.style?.backgroundColor),
                                  child: Text(extensionContext.element?.text.trim() ?? '',
                                      style: Theme.of(context).textTheme.bodyMedium),
                                )),
                          )),
                ],
              ),
            ));
  }
}

class AnchorWidget extends StatelessWidget {
  const AnchorWidget({
    required this.onClickedLink,
    required this.onGenerateKey,
    super.key,
    this.text = '',
    this.level = '',
  });

  final String text;
  final String level;
  final ValueChanged<String?> onClickedLink;
  final void Function(String value, GlobalKey key) onGenerateKey;

  String get anchorText =>
      '#${text.replaceAll(RegExp(r'[^\w\d ]+'), '').replaceAll(RegExp(r"\s+"), "-").toLowerCase()}';

  TextStyle? style(BuildContext context) {
    switch (level) {
      case 'h1':
        return Theme.of(context).textTheme.headlineMedium;
      case 'h2':
        return Theme.of(context).textTheme.headlineSmall;
      case 'h3':
        return Theme.of(context).textTheme.titleLarge;
    }
    return Theme.of(context).textTheme.headlineMedium;
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    onGenerateKey(anchorText, key);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          key: key,
          children: [
            TextButton(
              child: Text('#', style: style(context)?.apply(color: Theme.of(context).dividerColor)),
              onPressed: () {
                onClickedLink(anchorText);
              },
            ),
            Expanded(child: Text(text, style: style(context))),
          ]),
    );
  }
}

/*
 Created by Thanh Son on 29/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:objectx/objectx.dart';
import 'package:xml/xml.dart';

class SvgShield extends StatefulWidget {
  const SvgShield({
    super.key,
    required this.shieldUrl,
    this.newFontSize = '12',
    this.onTab,
  });

  final String shieldUrl;
  final String newFontSize;
  final VoidCallback? onTab;

  @override
  State<SvgShield> createState() => _SvgShieldState();
}

class _SvgShieldState extends State<SvgShield> {
  String? _rawData;
  String? _svg;

  Future<String> _fetchData() async {
    if (_rawData != null) return _rawData!;
    final data = await http.get(Uri.parse(widget.shieldUrl));
    _rawData = data.body;
    return _rawData!;
  }

  Future<String> _repairSvg() async {
    if (_svg != null) return _svg!;
    final rawData = await _fetchData();
    final xml = XmlDocument.parse(rawData);
    final fontSizeElem = xml.findAllElements('g').where(
          (e) => e.getAttribute('font-size')?.isANumber() ?? false,
        );
    // ignore: avoid_function_literals_in_foreach_calls
    fontSizeElem.forEach((element) {
      element.setAttribute('font-size', widget.newFontSize);
    });
    _svg = xml.toString();
    return _svg!;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
        future: _repairSvg(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return GestureDetector(onTap: widget.onTab, child: SvgPicture.string(snapshot.data!));
          }
          return SizedBox.shrink();
        },
      );
}

/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.item});

  final String item;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(loremIpsum(paragraphs: 5),
      )),
    );
  }
}

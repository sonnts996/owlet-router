/*
 Created by Thanh Son on 01/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';

class IconDataFromUri extends IconData {
  factory IconDataFromUri(String iconUrl) {
    final uri = Uri.parse(iconUrl);
    final query = uri.queryParameters;
    final codePoint = query['codePoint']!;
    final fontFamily = query['fontFamily'];
    final fontPackage = query['fontPackage'];
    return IconDataFromUri._(
      int.parse(codePoint),
      iconUrl: iconUrl,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );
  }

  const IconDataFromUri._(
    super.codePoint, {
    super.fontFamily,
    super.fontPackage,
    required this.iconUrl,
  });

  final String iconUrl;
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    required this.iconUrl,
    this.size = 24,
  });

  final String iconUrl;
  final double size;

  Uri? get uri => Uri.tryParse(iconUrl);

  @override
  Widget build(BuildContext context) {
    if (uri != null) {
      if (uri!.scheme == 'icondata') {
        final icon = IconDataFromUri(iconUrl);
        return Icon(icon, size: size);
      }
    }
    return SizedBox(height: size, width: size);
  }
}

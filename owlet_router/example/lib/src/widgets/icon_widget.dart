/*
 Created by Thanh Son on 01/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/utilities.dart';

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
    required this.iconUrl,
    super.fontFamily,
    super.fontPackage,
  });

  final String iconUrl;
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    required this.iconUrl,
    super.key,
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
      } else if (uri!.scheme == 'http' || uri!.scheme == 'https') {
        if (getUriExtension(uri!) == 'svg') {
          return SvgPicture.network(
            uri.toString(),
            height: size,
            width: size,
            placeholderBuilder: (context) => Placeholder(fallbackHeight: size, fallbackWidth: size),
          );
        } else {
          return CachedNetworkImage(
            imageUrl: uri.toString(),
            width: size,
            height: size,
            placeholder: (context, url) => Placeholder(fallbackHeight: size, fallbackWidth: size),
            errorWidget: (context, url, error) => Placeholder(fallbackHeight: size, fallbackWidth: size),
          );
        }
      } else {
        if (getUriExtension(uri!) == 'svg') {
          return SvgPicture.asset(
            uri.toString(),
            height: size,
            width: size,
            placeholderBuilder: (context) => Placeholder(fallbackHeight: size, fallbackWidth: size),
          );
        } else {
          return Image.asset(
            uri.toString(),
            width: size,
            height: size,
            errorBuilder: (context, error, stackTrace) => Placeholder(fallbackHeight: size, fallbackWidth: size),
          );
        }
      }
    }
    return SizedBox(height: size, width: size);
  }
}

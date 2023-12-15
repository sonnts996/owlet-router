/*
 Created by Thanh Son on 05/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/utilities.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    required this.imageUrl,
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final Alignment alignment;
  final BoxFit fit;

  Uri? get uri => Uri.tryParse(imageUrl);

  @override
  Widget build(BuildContext context) {
    if (uri == null) return const SizedBox.shrink();
    if (uri!.scheme == 'http' || uri!.scheme == 'https') {
      if (getUriExtension(uri!) == 'svg') {
        return SvgPicture.network(
          uri.toString(),
          height: height,
          width: width,
          alignment: alignment,
          fit: fit,
          placeholderBuilder: (context) => Placeholder(
              fallbackHeight: height ?? 400, fallbackWidth: width ?? 400),
        );
      } else {
        return CachedNetworkImage(
          imageUrl: uri.toString(),
          height: height,
          width: width,
          alignment: alignment,
          fit: fit,
          placeholder: (context, url) => Placeholder(
              fallbackHeight: height ?? 400, fallbackWidth: width ?? 400),
          errorWidget: (context, url, error) => Placeholder(
              fallbackHeight: height ?? 400, fallbackWidth: width ?? 400),
        );
      }
    } else {
      if (getUriExtension(uri!) == 'svg') {
        return SvgPicture.asset(
          uri.toString(),
          height: height,
          width: width,
          alignment: alignment,
          fit: fit,
          placeholderBuilder: (context) => Placeholder(
              fallbackHeight: height ?? 400, fallbackWidth: width ?? 400),
        );
      } else {
        return Image.asset(
          uri.toString(),
          height: height,
          width: width,
          alignment: alignment,
          fit: fit,
          errorBuilder: (context, error, _) => Placeholder(
              fallbackHeight: height ?? 400, fallbackWidth: width ?? 400),
        );
      }
    }
  }
}

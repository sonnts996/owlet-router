/*
 Created by Thanh Son on 28/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../widgets/svg_shield.dart';
import '../../domain/intefaces/package_interface.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.data,
    super.key,
  });

  final PackageInterface data;

  @override
  Widget build(BuildContext context) => _PackageCart(
        name: data.pubName,
        platformSupport: data.platform.toList(),
        sdkSupport: data.sdk.toList(),
        description: data.description,
        versionShieldUrl: data.shieldVersionUrl,
        onOpenPubLink: () {
          launchUrlString(data.pubUrl);
        },
      );
}

class _PackageCart extends StatelessWidget {
  const _PackageCart({
    required this.name,
    required this.onOpenPubLink,
    this.sdkSupport = const [],
    this.platformSupport = const [],
    this.description,
    this.versionShieldUrl,
  });

  final String name;
  final List<String> sdkSupport;
  final List<String> platformSupport;
  final String? description;
  final VoidCallback onOpenPubLink;
  final String? versionShieldUrl;

  @override
  Widget build(BuildContext context) => Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: const Offset(-4, 0),
                child: TextButton(
                  onPressed: onOpenPubLink,
                  child: Text(name,
                      style:
                          Theme.of(context).textTheme.titleSmall?.apply(color: Theme.of(context).colorScheme.primary)),
                ),
              ),
              const SizedBox(height: 4),
              if (versionShieldUrl != null)
                SizedBox(height: 20, child: SvgShield(shieldUrl: versionShieldUrl!, onTab: onOpenPubLink)),
              const SizedBox(height: 4),
              if (description != null)
                Text(
                  description!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelSmall?.apply(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
            ]),
      );
}

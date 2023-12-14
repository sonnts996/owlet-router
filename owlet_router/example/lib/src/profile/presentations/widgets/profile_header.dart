/*
 Created by Thanh Son on 28/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../domain/intefaces/profile_interface.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.data,
    super.key,
  });

  final ProfileInterface data;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 100,
      child: Stack(fit: StackFit.expand, alignment: Alignment.topLeft, children: [
        Positioned(
          left: 116,
          right: 8,
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(data.name.toUpperCase(),
                        style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.ellipsis),
                    Text.rich(TextSpan(
                        text: data.username,
                        children: [const TextSpan(text: ' · '), TextSpan(text: data.location)],
                        style: Theme.of(context).textTheme.labelMedium?.apply(color: Colors.black54))),
                  ],
                )),
                IconButton(
                    onPressed: () {
                      launchUrlString(data.githubUrl);
                    },
                    icon: SvgPicture.asset('assets/github-mark.svg', height: 24, width: 24)),
              ]),
              const Divider(indent: 0),
              Align(
                alignment: Alignment.bottomRight,
                child:
                    Text(data.bio, style: Theme.of(context).textTheme.labelMedium?.apply(fontStyle: FontStyle.italic)),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: const [BoxShadow(color: Color(0x05000000), spreadRadius: 6, blurRadius: 6)],
              ),
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(46),
                  child:
                      CircleAvatar(radius: 46, backgroundColor: Colors.white, child: Image.network(data.avatarUrl)))),
        ),
      ]));
}

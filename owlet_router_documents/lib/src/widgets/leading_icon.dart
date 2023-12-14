/*
 Created by Thanh Son on 27/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({
    super.key,
    this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context) => Navigator.canPop(context)
      ? IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: iconColor))
      : SizedBox.shrink();
}

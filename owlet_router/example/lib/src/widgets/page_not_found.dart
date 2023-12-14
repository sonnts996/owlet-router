/*
 Created by Thanh Son on 13/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(children: [
          SvgPicture.asset(
            'assets/logo_owlet.svg',
            height: 200,
            fit: BoxFit.fitHeight,
            color: Theme.of(context).disabledColor,
          ),
          Text(
            'Page Not Found',
            style: Theme.of(context).textTheme.displayMedium?.apply(color: Theme.of(context).disabledColor),
          )
        ]),
      );
}

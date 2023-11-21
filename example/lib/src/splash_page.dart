/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushNamed('/home');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [Color(0xFF6C89EE), Color(0xFF012FC5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: SvgPicture.asset(
          "assets/logo_owlet.svg",
          height: 300,
          fit: BoxFit.fitHeight,
        ),
      )),
    );
  }
}

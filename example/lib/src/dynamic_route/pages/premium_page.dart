/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Page'),
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                Color(0xFFFDCC91),
                Color(0xFFD4B483),
              ])),
          child: Text('If you can open this page, you are in premium mode.',
              style: Theme.of(context).textTheme.bodyMedium?.apply(color: Colors.white), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

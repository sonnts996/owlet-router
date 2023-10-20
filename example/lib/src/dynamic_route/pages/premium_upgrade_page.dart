/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/main.dart';
import 'package:flutter/material.dart';

class PremiumUpgradePage extends StatefulWidget {
  const PremiumUpgradePage({super.key});

  @override
  State<PremiumUpgradePage> createState() => _PremiumUpgradePageState();
}

class _PremiumUpgradePageState extends State<PremiumUpgradePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upgrade to Premium'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  navigatorServices.routeBase.dynamicRoute.upgradeToPremium();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Ink(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                        Color(0xFFFDCC91),
                        Color(0xFFD4B483),
                      ])),
                  child: Center(
                      child:
                          Text('Upgrade', style: Theme.of(context).textTheme.bodyMedium?.apply(color: Colors.white))),
                ),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () {
                  navigatorServices.routeBase.dynamicRoute.downgradeToPremium();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Downgrade'),
              ),
            ],
          ),
        ));
  }
}

/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:rowlet/rowlet.dart';

import '../../../main.dart';

class ReplacementPages extends StatefulWidget {
  const ReplacementPages({super.key, this.message});

  final String? message;

  @override
  State<ReplacementPages> createState() => _ReplacementPagesState();
}

class _ReplacementPagesState extends State<ReplacementPages> {
  final TextEditingController _argumentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('ReplacementPage'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Text('Message: ${widget.message ?? 'undefined'}'),
          )),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('(Check the console or press back)'),
            TextFormField(
                controller: _argumentController,
                decoration: const InputDecoration(hintText: 'Type any things', labelText: 'Arguments:')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  navigatorServices.routeBase.replacementSegments.replacement
                      .pushNamed(context, args: _argumentController.text);
                },
                child: const Text('Push New Replacement')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  final oldRoute = navigatorServices.history.nearest((e) =>
                      navigatorServices.routeBase.replacementSegments.replacement.isRoute(e) &&
                      e.settings.arguments == _argumentController.text);
                  if (oldRoute != null) {
                    Navigator.replace(context,
                        oldRoute: oldRoute.route,
                        newRoute: navigatorServices.routeBase.replacementSegments.replacement
                            .toRoute(args: 'This route was replaced.')!);
                  } else {
                    print('Nothing matches');
                  }
                },
                child: const Text('Replace route, which matches the Arguments')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  final routeFinder = navigatorServices.history.nearest((e) =>
                      navigatorServices.routeBase.replacementSegments.replacement.isRoute(e) &&
                      e.settings.arguments == _argumentController.text);
                  if (routeFinder != null) {
                    Navigator.removeRoute(context, routeFinder.route);
                  } else {
                    print('Nothing matches');
                  }
                },
                child: const Text('Remove route, which matches the Arguments')),
          ],
        ),
      )),
    );
  }
}

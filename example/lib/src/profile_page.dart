/*
 Created by Thanh Son on 09/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    backgroundColor: Colors.indigoAccent,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(CupertinoIcons.back,
                            color: Colors.white)),
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final isExpanded =
                            constraints.maxHeight > (kToolbarHeight + 100);
                        return FlexibleSpaceBar(
                          titlePadding: isExpanded
                              ? const EdgeInsets.fromLTRB(0, 0, 0, 16)
                              : null,
                          centerTitle: true,
                          background: DecoratedBox(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFEDE0CD),
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(24))),
                                  alignment: Alignment.bottomCenter,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxWidth: 300,
                                        minHeight: 100,
                                        maxHeight: 300),
                                    child: Image.asset(
                                        'assets/owlets_on_the_tree.jpg',
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.bottomCenter),
                                  ))),
                          title: isExpanded
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 2,
                                                  blurRadius: 2)
                                            ]),
                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child: ShaderMask(
                                              shaderCallback: (bounds) {
                                                return const LinearGradient(
                                                  colors: [
                                                    Color(0xFF6C89EE),
                                                    Color(0xFF012FC5)
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds);
                                              },
                                              child: SvgPicture.asset(
                                                "assets/logo_owlet.svg",
                                                height: 30,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            )),
                                      ),
                                      const SizedBox(height: 4),
                                      Text("I'm Owlet",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.apply(
                                                  color: Colors.white,
                                                  shadows: [
                                                const BoxShadow(
                                                    color: Colors.black54,
                                                    spreadRadius: 5,
                                                    blurRadius: 5)
                                              ])),
                                    ])
                              : Text("I'm Owlet",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.apply(color: Colors.white)),
                        );
                      },
                    ))
              ],
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About me:',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text.rich(
                      TextSpan(text: 'The ', children: [
                        TextSpan(
                            text: 'owlet_router',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.apply(fontWeightDelta: 2)),
                        const TextSpan(
                            text:
                                ' is a route manager, not a route itself. It utilizes the route builder to construct the router.')
                      ]),
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  const Text('It is designed with several purposes in mind:'),
                  const Text('''
- Providing a clear and easily definable route manager that is simple to read and use.
- Built upon the base Flutter Router, allowing for integration with various page route types and the
  ability to customize and extend the router.
- Enabling modularization of the router, making it easy to segment routes and create independent
  routes.
- Offering the capability to check, prevent, or redirect routes before they are pushed.
''')
                ]),
          )),
    );
  }
}

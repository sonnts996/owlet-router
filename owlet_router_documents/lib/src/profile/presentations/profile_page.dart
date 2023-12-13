/*
 Created by Thanh Son on 09/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:fluid_kit/fluid_kit.dart';
import 'package:flutter/material.dart';

import '../../../gen/injections.dart';
import '../../widgets/body_container.dart';
import '../../widgets/leading_icon.dart';
import '../domain/intefaces/profile_interface.dart';
import '../domain/usecases/profile_usecase.dart';
import 'widgets/error_view.dart';
import 'widgets/loading_view.dart';
import 'widgets/package_card.dart';
import 'widgets/profile_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileUseCase profileUseCase = getIt.get<ProfileUseCase>();

  @override
  Widget build(BuildContext context) => BodyContainer(
        child: FutureBuilder<ProfileInterface>(
            future: profileUseCase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingView();
              } else if (snapshot.data == null) {
                return ErrorView(error: snapshot.error);
              }
              final data = snapshot.data!;
              return Scaffold(
                  appBar: AppBar(
                    centerTitle: false,
                    leading: const LeadingIcon(),
                    title: const Text('Author'),
                  ),
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileHeader(data: data),
                          const SizedBox(height: 24),
                          Text('Suggest Flutter packages:', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Fluid(
                            spacing: 8,
                            lineSpacing: 8,
                            children:
                                data.repos.map((e) => Fluidable(minWidth: 300, child: PackageCard(data: e))).toList(),
                          )
                        ]),
                  ));
            }),
      );
}

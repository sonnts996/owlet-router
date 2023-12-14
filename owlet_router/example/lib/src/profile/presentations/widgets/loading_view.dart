/*
 Created by Thanh Son on 27/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';

import '../../../widgets/leading_icon.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar:
            AppBar(title: const Text('Author'), leading: const LeadingIcon()),
        body: Center(child: CircularProgressIndicator()),
      );
}

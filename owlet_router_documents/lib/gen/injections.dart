/*
 Created by Thanh Son on 01/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injections.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();

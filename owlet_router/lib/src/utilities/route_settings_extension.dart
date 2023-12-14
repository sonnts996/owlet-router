/*
 Created by Thanh Son on 05/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:objectx/objectx.dart';

///
/// Extension to read the URI from the name.
extension RouteSettingsReader on RouteSettings {
  ///
  /// try to parse the [name] into Uri
  Uri? get uri => name?.let(Uri.tryParse);

  ///
  /// If the [name] can parse into Uri, this function returns the Uri's path.
  String? get path => uri?.path;

  ///
  /// If the [name] can parse into Uri, this function returns the Uri's fragment.
  String? get fragment => uri?.fragment;

  ///
  /// If the [name] can parse into Uri, this function returns the Uri's queryParameters.
  Map<String, String>? get queryParameters => uri?.queryParameters;

  ///
  /// If the [name] can parse into Uri, this function returns the Uri's queryParametersAll.
  Map<String, List<String>>? get queryParametersAll => uri?.queryParametersAll;
}

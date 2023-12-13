/*
 Created by Thanh Son on 26/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package_interface.dart';

abstract class ProfileInterface {
  String get name;

  String get avatarUrl;

  String get githubUrl;

  String get repoUrl;

  String get bio;

  String get username;

  String get location;

  Iterable<PackageInterface> get repos;
}

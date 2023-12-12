/*
 Created by Thanh Son on 27/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
abstract class PackageInterface {
  String get repoName;

  String get pubName;

  Iterable<String> get sdk;

  Iterable<String> get platform;

  String get pubUrl;

  String get gitUrl;

  String get description;

  String get shieldVersionUrl;
}

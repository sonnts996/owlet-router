/*
 Created by Thanh Son on 01/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
abstract class MetaDataInterface {
  String get name;

  String get package;

  String get lang;

  String get icon;

  Iterable<RepoMetaDataInterface> get repo;

  Iterable<DocLanguageInterface> get docLanguages;

  PageInterface get homePage;

  Iterable<PageInterface> get pages;
}

abstract class RepoMetaDataInterface {
  String get label;

  String get url;

  String get icon;
}

abstract class DocLanguageInterface {
  String get lang;

  String get label;
}

abstract class PageInterface {
  String? get coverImage;

  String? get coverBackground;

  MenuItemInterface get menuItem;

  Iterable<DocumentMetaDataInterface> get data;
}

abstract class MenuItemInterface {
  String get icon;

  String get label;

  String get segment;
}

abstract class DocumentMetaDataInterface {
  String get fragment;

  String get title;

  String get icon;

  String get file;
}

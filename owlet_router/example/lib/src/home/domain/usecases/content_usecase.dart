/*
 Created by Thanh Son on 29/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:objectx/objectx.dart';

import '../../data/document_datasource.dart';

@LazySingleton()
class ContentUseCase {
  ContentUseCase(this.datasource);

  final DocumentDatasource datasource;

  Future<String> call(String file) async {
    try {
      return await datasource.getContent(file);
    } catch (e) {
      e.print(tag: 'MetaDataUseCase', debugMode: kDebugMode);
      rethrow;
    }
  }
}

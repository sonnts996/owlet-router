/*
 Created by Thanh Son on 29/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:objectx/objectx.dart';

import '../../data/document_datasource.dart';
import '../interfaces/metadata_interface.dart';

@LazySingleton()
class MetaDataUseCase {
  MetaDataUseCase(this.datasource);

  final DocumentDatasource datasource;

  Future<MetaDataInterface> call() async {
    try {
      return await datasource.getMetaData();
    } catch (e) {
      e.print(tag: 'MetaDataUseCase', debugMode: kDebugMode);
      rethrow;
    }
  }
}

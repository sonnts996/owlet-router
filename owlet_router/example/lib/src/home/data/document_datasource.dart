/*
 Created by Thanh Son on 29/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../domain/interfaces/metadata_interface.dart';
import 'models/metadata_model.dart';

@LazySingleton()
class DocumentDatasource {
  Future<MetaDataInterface> getMetaData() async {
    final result = await rootBundle.loadString('documents/home/index.json');
    return MetaDataModel.fromJson(jsonDecode(result));
  }

  Future<String> getContent(String file) async => await rootBundle.loadString(file);
}

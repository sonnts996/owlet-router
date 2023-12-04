/*
 Created by Thanh Son on 28/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:injectable/injectable.dart';
import 'package:objectx/objectx.dart';

import '../../data/profile_datasource.dart';
import '../intefaces/profile_interface.dart';

@LazySingleton()
class ProfileUseCase {
  ProfileUseCase(this.profileDataSource);

  final ProfileDataSource profileDataSource;

  Future<ProfileInterface> call() async {
    try {
      final result = await profileDataSource.getAuthorDto();
      return result;
    } catch (e) {
      e.print();
      rethrow;
    }
  }
}

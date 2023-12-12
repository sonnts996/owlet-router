/*
 Created by Thanh Son on 28/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../domain/intefaces/package_interface.dart';
import '../../domain/intefaces/profile_interface.dart';

part 'profile_model.g.dart';

abstract class ProfileModel implements ProfileInterface, Built<ProfileModel, ProfileModelBuilder> {
  factory ProfileModel([void Function(ProfileModelBuilder) updates]) = _$ProfileModel;

  const ProfileModel._();

  @override
  BuiltList<PackageInterface> get repos;
}

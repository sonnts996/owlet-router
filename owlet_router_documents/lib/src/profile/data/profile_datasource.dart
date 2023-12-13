/*
 Created by Thanh Son on 26/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../utilities/utilities.dart';
import '../domain/intefaces/profile_interface.dart';
import 'model/author_dto_model.dart';
import 'model/github_profile_model.dart';
import 'model/profile_model.dart';

@LazySingleton()
class ProfileDataSource {
  final dio = Dio();

  AuthorDtoModel? authorDto;
  GitHubProfileModel? githubProfile;

  Future<ProfileInterface> getAuthorDto() async {
    if (authorDto == null) {
      final assets = await rootBundle.loadString('documents/author/index.json', cache: true);
      authorDto = AuthorDtoModel.fromJson(jsonDecode(assets));
    }
    if (githubProfile == null) {
      final response = await dio.get(replace(authorDto!.gitApi, {'username': authorDto!.username}));
      githubProfile = GitHubProfileModel.fromJson(response.data as Map<String, dynamic>);
    }
    return ProfileModel((p0) {
      p0
        ..name = githubProfile!.name
        ..username = authorDto!.username
        ..bio = githubProfile!.bio
        ..repos = ListBuilder(authorDto!.repos)
        ..githubUrl = githubProfile!.htmlUrl
        ..repoUrl = ''
        ..avatarUrl = githubProfile!.avatarUrl
        ..location = githubProfile!.location;
    });
  }
}

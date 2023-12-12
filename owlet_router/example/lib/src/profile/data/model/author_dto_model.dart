/*
 Created by Thanh Son on 27/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:json_annotation/json_annotation.dart';

import '../../../utilities/utilities.dart';
import '../../domain/intefaces/package_interface.dart';

part 'author_dto_model.g.dart';

@JsonSerializable()
class AuthorDtoModel {
  AuthorDtoModel({
    required this.username,
    required this.publisher,
    required this.repos,
    required this.gitApi,
  });

  factory AuthorDtoModel.fromJson(Map<String, dynamic> json) => _$AuthorDtoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDtoModelToJson(this);

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'publisher')
  final String publisher;

  final List<Repos> repos;

  @JsonKey(name: 'git_api')
  final String gitApi;
}

@JsonSerializable()
class Repos extends PackageInterface {
  Repos({
    required this.repoName,
    required this.pubName,
    required this.sdk,
    required this.platform,
    required this.description,
    required this.shieldVersion,
    required this.githubUrl,
    required this.pubUrlAlt,
  });

  factory Repos.fromJson(Map<String, dynamic> json) => _$ReposFromJson(json);

  @override
  @JsonKey(name: 'repo_name')
  final String repoName;

  @override
  @JsonKey(name: 'pub_name')
  final String pubName;

  @override
  @JsonKey(name: 'sdk')
  final List<String> sdk;

  @override
  @JsonKey(name: 'platform')
  final List<String> platform;

  @override
  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'shield_version')
  final String shieldVersion;

  @JsonKey(name: 'github_url')
  final String githubUrl;

  @JsonKey(name: 'pub_url')
  final String pubUrlAlt;

  @override
  String get pubUrl => replace(pubUrlAlt, {'pub_name': pubName});

  @override
  String get gitUrl => replace(githubUrl, {'repo_name': repoName});

  @override
  String get shieldVersionUrl => replace(shieldVersion, {'pub_name': pubName});

  Map<String, dynamic> toJson() => _$ReposToJson(this);
}

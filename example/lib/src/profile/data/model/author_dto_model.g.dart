// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorDtoModel _$AuthorDtoModelFromJson(Map<String, dynamic> json) =>
    AuthorDtoModel(
      username: json['username'] as String,
      publisher: json['publisher'] as String,
      repos: (json['repos'] as List<dynamic>)
          .map((e) => Repos.fromJson(e as Map<String, dynamic>))
          .toList(),
      gitApi: json['git_api'] as String,
    );

Map<String, dynamic> _$AuthorDtoModelToJson(AuthorDtoModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'publisher': instance.publisher,
      'repos': instance.repos,
      'git_api': instance.gitApi,
    };

Repos _$ReposFromJson(Map<String, dynamic> json) => Repos(
      repoName: json['repo_name'] as String,
      pubName: json['pub_name'] as String,
      sdk: (json['sdk'] as List<dynamic>).map((e) => e as String).toList(),
      platform:
          (json['platform'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      shieldVersion: json['shield_version'] as String,
      githubUrl: json['github_url'] as String,
      pubUrlAlt: json['pub_url'] as String,
    );

Map<String, dynamic> _$ReposToJson(Repos instance) => <String, dynamic>{
      'repo_name': instance.repoName,
      'pub_name': instance.pubName,
      'sdk': instance.sdk,
      'platform': instance.platform,
      'description': instance.description,
      'shield_version': instance.shieldVersion,
      'github_url': instance.githubUrl,
      'pub_url': instance.pubUrlAlt,
    };

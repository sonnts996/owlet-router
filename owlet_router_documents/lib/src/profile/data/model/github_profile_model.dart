/*
 Created by Thanh Son on 26/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:json_annotation/json_annotation.dart';

part 'github_profile_model.g.dart';

@JsonSerializable()
class GitHubProfileModel {
  GitHubProfileModel(
      {required this.login,
      required this.id,
      required this.nodeId,
      required this.avatarUrl,
      required this.gravatarId,
      required this.url,
      required this.htmlUrl,
      required this.followersUrl,
      required this.followingUrl,
      required this.gistsUrl,
      required this.starredUrl,
      required this.subscriptionsUrl,
      required this.organizationsUrl,
      required this.reposUrl,
      required this.eventsUrl,
      required this.receivedEventsUrl,
      required this.type,
      required this.siteAdmin,
      required this.name,
      required this.company,
      required this.blog,
      required this.location,
      required this.email,
      required this.hireable,
      required this.bio,
      required this.twitterUsername,
      required this.publicRepos,
      required this.publicGists,
      required this.followers,
      required this.following,
      required this.createdAt,
      required this.updatedAt});

  factory GitHubProfileModel.fromJson(Map<String, dynamic> json) =>
      _$GitHubProfileModelFromJson(json);

  @JsonKey(name: 'login')
  final String? login;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'node_id')
  final String? nodeId;

  @JsonKey(name: 'avatar_url', defaultValue: '')
  final String avatarUrl;

  @JsonKey(name: 'gravatar_id')
  final String? gravatarId;

  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'html_url')
  final String? htmlUrl;

  @JsonKey(name: 'followers_url')
  final String? followersUrl;

  @JsonKey(name: 'following_url')
  final String? followingUrl;

  @JsonKey(name: 'gists_url')
  final String? gistsUrl;

  @JsonKey(name: 'starred_url')
  final String? starredUrl;

  @JsonKey(name: 'subscriptions_url')
  final String? subscriptionsUrl;

  @JsonKey(name: 'organizations_url')
  final String? organizationsUrl;

  @JsonKey(name: 'repos_url')
  final String? reposUrl;

  @JsonKey(name: 'events_url')
  final String? eventsUrl;

  @JsonKey(name: 'received_events_url')
  final String? receivedEventsUrl;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'site_admin')
  final bool? siteAdmin;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'company')
  final String? company;

  @JsonKey(name: 'blog')
  final String? blog;

  @JsonKey(name: 'location')
  final String location;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'hireable')
  final bool? hireable;

  @JsonKey(name: 'bio', defaultValue: '')
  final String bio;

  @JsonKey(name: 'twitter_username')
  final String? twitterUsername;

  @JsonKey(name: 'public_repos')
  final int? publicRepos;

  @JsonKey(name: 'public_gists')
  final int? publicGists;

  @JsonKey(name: 'followers')
  final int? followers;

  @JsonKey(name: 'following')
  final int? following;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Map<String, dynamic> toJson() => _$GitHubProfileModelToJson(this);
}

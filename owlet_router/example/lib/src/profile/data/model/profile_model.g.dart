// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProfileModel extends ProfileModel {
  @override
  final BuiltList<PackageInterface> repos;
  @override
  final String name;
  @override
  final String avatarUrl;
  @override
  final String githubUrl;
  @override
  final String repoUrl;
  @override
  final String bio;
  @override
  final String username;
  @override
  final String location;

  factory _$ProfileModel([void Function(ProfileModelBuilder)? updates]) =>
      (new ProfileModelBuilder()..update(updates))._build();

  _$ProfileModel._(
      {required this.repos,
      required this.name,
      required this.avatarUrl,
      required this.githubUrl,
      required this.repoUrl,
      required this.bio,
      required this.username,
      required this.location})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(repos, r'ProfileModel', 'repos');
    BuiltValueNullFieldError.checkNotNull(name, r'ProfileModel', 'name');
    BuiltValueNullFieldError.checkNotNull(
        avatarUrl, r'ProfileModel', 'avatarUrl');
    BuiltValueNullFieldError.checkNotNull(
        githubUrl, r'ProfileModel', 'githubUrl');
    BuiltValueNullFieldError.checkNotNull(repoUrl, r'ProfileModel', 'repoUrl');
    BuiltValueNullFieldError.checkNotNull(bio, r'ProfileModel', 'bio');
    BuiltValueNullFieldError.checkNotNull(
        username, r'ProfileModel', 'username');
    BuiltValueNullFieldError.checkNotNull(
        location, r'ProfileModel', 'location');
  }

  @override
  ProfileModel rebuild(void Function(ProfileModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileModelBuilder toBuilder() => new ProfileModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileModel &&
        repos == other.repos &&
        name == other.name &&
        avatarUrl == other.avatarUrl &&
        githubUrl == other.githubUrl &&
        repoUrl == other.repoUrl &&
        bio == other.bio &&
        username == other.username &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, repos.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, githubUrl.hashCode);
    _$hash = $jc(_$hash, repoUrl.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProfileModel')
          ..add('repos', repos)
          ..add('name', name)
          ..add('avatarUrl', avatarUrl)
          ..add('githubUrl', githubUrl)
          ..add('repoUrl', repoUrl)
          ..add('bio', bio)
          ..add('username', username)
          ..add('location', location))
        .toString();
  }
}

class ProfileModelBuilder
    implements Builder<ProfileModel, ProfileModelBuilder> {
  _$ProfileModel? _$v;

  ListBuilder<PackageInterface>? _repos;
  ListBuilder<PackageInterface> get repos =>
      _$this._repos ??= new ListBuilder<PackageInterface>();
  set repos(ListBuilder<PackageInterface>? repos) => _$this._repos = repos;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  String? _githubUrl;
  String? get githubUrl => _$this._githubUrl;
  set githubUrl(String? githubUrl) => _$this._githubUrl = githubUrl;

  String? _repoUrl;
  String? get repoUrl => _$this._repoUrl;
  set repoUrl(String? repoUrl) => _$this._repoUrl = repoUrl;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  ProfileModelBuilder();

  ProfileModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _repos = $v.repos.toBuilder();
      _name = $v.name;
      _avatarUrl = $v.avatarUrl;
      _githubUrl = $v.githubUrl;
      _repoUrl = $v.repoUrl;
      _bio = $v.bio;
      _username = $v.username;
      _location = $v.location;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProfileModel;
  }

  @override
  void update(void Function(ProfileModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProfileModel build() => _build();

  _$ProfileModel _build() {
    _$ProfileModel _$result;
    try {
      _$result = _$v ??
          new _$ProfileModel._(
              repos: repos.build(),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'ProfileModel', 'name'),
              avatarUrl: BuiltValueNullFieldError.checkNotNull(
                  avatarUrl, r'ProfileModel', 'avatarUrl'),
              githubUrl: BuiltValueNullFieldError.checkNotNull(
                  githubUrl, r'ProfileModel', 'githubUrl'),
              repoUrl: BuiltValueNullFieldError.checkNotNull(
                  repoUrl, r'ProfileModel', 'repoUrl'),
              bio: BuiltValueNullFieldError.checkNotNull(
                  bio, r'ProfileModel', 'bio'),
              username: BuiltValueNullFieldError.checkNotNull(
                  username, r'ProfileModel', 'username'),
              location: BuiltValueNullFieldError.checkNotNull(
                  location, r'ProfileModel', 'location'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'repos';
        repos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProfileModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

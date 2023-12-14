// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$_serializers = (new Serializers().toBuilder()
      ..add(DocLanguageModel.serializer)
      ..add(MenuItemModel.serializer)
      ..add(MetaDataModel.serializer)
      ..add(PageModel.serializer)
      ..add(RepoMetaDataModel.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(MenuItemModel)]),
          () => new ListBuilder<MenuItemModel>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(RepoMetaDataModel)]),
          () => new ListBuilder<RepoMetaDataModel>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(DocLanguageModel)]),
          () => new ListBuilder<DocLanguageModel>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(PageModel)]),
          () => new ListBuilder<PageModel>()))
    .build();
Serializer<MetaDataModel> _$metaDataModelSerializer =
    new _$MetaDataModelSerializer();
Serializer<RepoMetaDataModel> _$repoMetaDataModelSerializer =
    new _$RepoMetaDataModelSerializer();
Serializer<DocLanguageModel> _$docLanguageModelSerializer =
    new _$DocLanguageModelSerializer();
Serializer<PageModel> _$pageModelSerializer = new _$PageModelSerializer();
Serializer<MenuItemModel> _$menuItemModelSerializer =
    new _$MenuItemModelSerializer();

class _$MetaDataModelSerializer implements StructuredSerializer<MetaDataModel> {
  @override
  final Iterable<Type> types = const [MetaDataModel, _$MetaDataModel];
  @override
  final String wireName = 'MetaDataModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, MetaDataModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'repo',
      serializers.serialize(object.repo,
          specifiedType: const FullType(
              BuiltList, const [const FullType(RepoMetaDataModel)])),
      'doc-languages',
      serializers.serialize(object.docLanguages,
          specifiedType: const FullType(
              BuiltList, const [const FullType(DocLanguageModel)])),
      'home-page',
      serializers.serialize(object.homePage,
          specifiedType: const FullType(PageModel)),
      'pages',
      serializers.serialize(object.pages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(PageModel)])),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'package',
      serializers.serialize(object.package,
          specifiedType: const FullType(String)),
      'lang',
      serializers.serialize(object.lang, specifiedType: const FullType(String)),
      'icon',
      serializers.serialize(object.icon, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  MetaDataModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MetaDataModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'repo':
          result.repo.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(RepoMetaDataModel)]))!
              as BuiltList<Object?>);
          break;
        case 'doc-languages':
          result.docLanguages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocLanguageModel)]))!
              as BuiltList<Object?>);
          break;
        case 'home-page':
          result.homePage.replace(serializers.deserialize(value,
              specifiedType: const FullType(PageModel))! as PageModel);
          break;
        case 'pages':
          result.pages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PageModel)]))!
              as BuiltList<Object?>);
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'package':
          result.package = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'lang':
          result.lang = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$RepoMetaDataModelSerializer
    implements StructuredSerializer<RepoMetaDataModel> {
  @override
  final Iterable<Type> types = const [RepoMetaDataModel, _$RepoMetaDataModel];
  @override
  final String wireName = 'RepoMetaDataModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, RepoMetaDataModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'label',
      serializers.serialize(object.label,
          specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'icon',
      serializers.serialize(object.icon, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  RepoMetaDataModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RepoMetaDataModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DocLanguageModelSerializer
    implements StructuredSerializer<DocLanguageModel> {
  @override
  final Iterable<Type> types = const [DocLanguageModel, _$DocLanguageModel];
  @override
  final String wireName = 'DocLanguageModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, DocLanguageModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'lang',
      serializers.serialize(object.lang, specifiedType: const FullType(String)),
      'label',
      serializers.serialize(object.label,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DocLanguageModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DocLanguageModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'lang':
          result.lang = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PageModelSerializer implements StructuredSerializer<PageModel> {
  @override
  final Iterable<Type> types = const [PageModel, _$PageModel];
  @override
  final String wireName = 'PageModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, PageModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'menu-label',
      serializers.serialize(object.label,
          specifiedType: const FullType(MenuItemModel)),
      'menu-items',
      serializers.serialize(object.items,
          specifiedType:
              const FullType(BuiltList, const [const FullType(MenuItemModel)])),
    ];
    Object? value;
    value = object.coverImage;
    if (value != null) {
      result
        ..add('cover-image')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.coverBackground;
    if (value != null) {
      result
        ..add('cover-background')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.file;
    if (value != null) {
      result
        ..add('file')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PageModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PageModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'cover-image':
          result.coverImage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'cover-background':
          result.coverBackground = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'menu-label':
          result.label.replace(serializers.deserialize(value,
              specifiedType: const FullType(MenuItemModel))! as MenuItemModel);
          break;
        case 'menu-items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(MenuItemModel)]))!
              as BuiltList<Object?>);
          break;
        case 'file':
          result.file = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$MenuItemModelSerializer implements StructuredSerializer<MenuItemModel> {
  @override
  final Iterable<Type> types = const [MenuItemModel, _$MenuItemModel];
  @override
  final String wireName = 'MenuItemModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, MenuItemModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'icon',
      serializers.serialize(object.icon, specifiedType: const FullType(String)),
      'label',
      serializers.serialize(object.label,
          specifiedType: const FullType(String)),
      'segment',
      serializers.serialize(object.segment,
          specifiedType: const FullType(String)),
      'fragment',
      serializers.serialize(object.fragment,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  MenuItemModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MenuItemModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'icon':
          result.icon = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'segment':
          result.segment = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'fragment':
          result.fragment = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$MetaDataModel extends MetaDataModel {
  @override
  final BuiltList<RepoMetaDataModel> repo;
  @override
  final BuiltList<DocLanguageModel> docLanguages;
  @override
  final PageModel homePage;
  @override
  final BuiltList<PageModel> pages;
  @override
  final String name;
  @override
  final String package;
  @override
  final String lang;
  @override
  final String icon;

  factory _$MetaDataModel([void Function(MetaDataModelBuilder)? updates]) =>
      (new MetaDataModelBuilder()..update(updates))._build();

  _$MetaDataModel._(
      {required this.repo,
      required this.docLanguages,
      required this.homePage,
      required this.pages,
      required this.name,
      required this.package,
      required this.lang,
      required this.icon})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(repo, r'MetaDataModel', 'repo');
    BuiltValueNullFieldError.checkNotNull(
        docLanguages, r'MetaDataModel', 'docLanguages');
    BuiltValueNullFieldError.checkNotNull(
        homePage, r'MetaDataModel', 'homePage');
    BuiltValueNullFieldError.checkNotNull(pages, r'MetaDataModel', 'pages');
    BuiltValueNullFieldError.checkNotNull(name, r'MetaDataModel', 'name');
    BuiltValueNullFieldError.checkNotNull(package, r'MetaDataModel', 'package');
    BuiltValueNullFieldError.checkNotNull(lang, r'MetaDataModel', 'lang');
    BuiltValueNullFieldError.checkNotNull(icon, r'MetaDataModel', 'icon');
  }

  @override
  MetaDataModel rebuild(void Function(MetaDataModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MetaDataModelBuilder toBuilder() => new MetaDataModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MetaDataModel &&
        repo == other.repo &&
        docLanguages == other.docLanguages &&
        homePage == other.homePage &&
        pages == other.pages &&
        name == other.name &&
        package == other.package &&
        lang == other.lang &&
        icon == other.icon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, repo.hashCode);
    _$hash = $jc(_$hash, docLanguages.hashCode);
    _$hash = $jc(_$hash, homePage.hashCode);
    _$hash = $jc(_$hash, pages.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, package.hashCode);
    _$hash = $jc(_$hash, lang.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MetaDataModel')
          ..add('repo', repo)
          ..add('docLanguages', docLanguages)
          ..add('homePage', homePage)
          ..add('pages', pages)
          ..add('name', name)
          ..add('package', package)
          ..add('lang', lang)
          ..add('icon', icon))
        .toString();
  }
}

class MetaDataModelBuilder
    implements Builder<MetaDataModel, MetaDataModelBuilder> {
  _$MetaDataModel? _$v;

  ListBuilder<RepoMetaDataModel>? _repo;
  ListBuilder<RepoMetaDataModel> get repo =>
      _$this._repo ??= new ListBuilder<RepoMetaDataModel>();
  set repo(ListBuilder<RepoMetaDataModel>? repo) => _$this._repo = repo;

  ListBuilder<DocLanguageModel>? _docLanguages;
  ListBuilder<DocLanguageModel> get docLanguages =>
      _$this._docLanguages ??= new ListBuilder<DocLanguageModel>();
  set docLanguages(ListBuilder<DocLanguageModel>? docLanguages) =>
      _$this._docLanguages = docLanguages;

  PageModelBuilder? _homePage;
  PageModelBuilder get homePage => _$this._homePage ??= new PageModelBuilder();
  set homePage(PageModelBuilder? homePage) => _$this._homePage = homePage;

  ListBuilder<PageModel>? _pages;
  ListBuilder<PageModel> get pages =>
      _$this._pages ??= new ListBuilder<PageModel>();
  set pages(ListBuilder<PageModel>? pages) => _$this._pages = pages;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _package;
  String? get package => _$this._package;
  set package(String? package) => _$this._package = package;

  String? _lang;
  String? get lang => _$this._lang;
  set lang(String? lang) => _$this._lang = lang;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  MetaDataModelBuilder();

  MetaDataModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _repo = $v.repo.toBuilder();
      _docLanguages = $v.docLanguages.toBuilder();
      _homePage = $v.homePage.toBuilder();
      _pages = $v.pages.toBuilder();
      _name = $v.name;
      _package = $v.package;
      _lang = $v.lang;
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MetaDataModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MetaDataModel;
  }

  @override
  void update(void Function(MetaDataModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MetaDataModel build() => _build();

  _$MetaDataModel _build() {
    _$MetaDataModel _$result;
    try {
      _$result = _$v ??
          new _$MetaDataModel._(
              repo: repo.build(),
              docLanguages: docLanguages.build(),
              homePage: homePage.build(),
              pages: pages.build(),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'MetaDataModel', 'name'),
              package: BuiltValueNullFieldError.checkNotNull(
                  package, r'MetaDataModel', 'package'),
              lang: BuiltValueNullFieldError.checkNotNull(
                  lang, r'MetaDataModel', 'lang'),
              icon: BuiltValueNullFieldError.checkNotNull(
                  icon, r'MetaDataModel', 'icon'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'repo';
        repo.build();
        _$failedField = 'docLanguages';
        docLanguages.build();
        _$failedField = 'homePage';
        homePage.build();
        _$failedField = 'pages';
        pages.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MetaDataModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$RepoMetaDataModel extends RepoMetaDataModel {
  @override
  final String label;
  @override
  final String url;
  @override
  final String icon;

  factory _$RepoMetaDataModel(
          [void Function(RepoMetaDataModelBuilder)? updates]) =>
      (new RepoMetaDataModelBuilder()..update(updates))._build();

  _$RepoMetaDataModel._(
      {required this.label, required this.url, required this.icon})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(label, r'RepoMetaDataModel', 'label');
    BuiltValueNullFieldError.checkNotNull(url, r'RepoMetaDataModel', 'url');
    BuiltValueNullFieldError.checkNotNull(icon, r'RepoMetaDataModel', 'icon');
  }

  @override
  RepoMetaDataModel rebuild(void Function(RepoMetaDataModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RepoMetaDataModelBuilder toBuilder() =>
      new RepoMetaDataModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RepoMetaDataModel &&
        label == other.label &&
        url == other.url &&
        icon == other.icon;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RepoMetaDataModel')
          ..add('label', label)
          ..add('url', url)
          ..add('icon', icon))
        .toString();
  }
}

class RepoMetaDataModelBuilder
    implements Builder<RepoMetaDataModel, RepoMetaDataModelBuilder> {
  _$RepoMetaDataModel? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  RepoMetaDataModelBuilder();

  RepoMetaDataModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _url = $v.url;
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RepoMetaDataModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RepoMetaDataModel;
  }

  @override
  void update(void Function(RepoMetaDataModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RepoMetaDataModel build() => _build();

  _$RepoMetaDataModel _build() {
    final _$result = _$v ??
        new _$RepoMetaDataModel._(
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'RepoMetaDataModel', 'label'),
            url: BuiltValueNullFieldError.checkNotNull(
                url, r'RepoMetaDataModel', 'url'),
            icon: BuiltValueNullFieldError.checkNotNull(
                icon, r'RepoMetaDataModel', 'icon'));
    replace(_$result);
    return _$result;
  }
}

class _$DocLanguageModel extends DocLanguageModel {
  @override
  final String lang;
  @override
  final String label;

  factory _$DocLanguageModel(
          [void Function(DocLanguageModelBuilder)? updates]) =>
      (new DocLanguageModelBuilder()..update(updates))._build();

  _$DocLanguageModel._({required this.lang, required this.label}) : super._() {
    BuiltValueNullFieldError.checkNotNull(lang, r'DocLanguageModel', 'lang');
    BuiltValueNullFieldError.checkNotNull(label, r'DocLanguageModel', 'label');
  }

  @override
  DocLanguageModel rebuild(void Function(DocLanguageModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DocLanguageModelBuilder toBuilder() =>
      new DocLanguageModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DocLanguageModel &&
        lang == other.lang &&
        label == other.label;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, lang.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DocLanguageModel')
          ..add('lang', lang)
          ..add('label', label))
        .toString();
  }
}

class DocLanguageModelBuilder
    implements Builder<DocLanguageModel, DocLanguageModelBuilder> {
  _$DocLanguageModel? _$v;

  String? _lang;
  String? get lang => _$this._lang;
  set lang(String? lang) => _$this._lang = lang;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  DocLanguageModelBuilder();

  DocLanguageModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lang = $v.lang;
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DocLanguageModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DocLanguageModel;
  }

  @override
  void update(void Function(DocLanguageModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DocLanguageModel build() => _build();

  _$DocLanguageModel _build() {
    final _$result = _$v ??
        new _$DocLanguageModel._(
            lang: BuiltValueNullFieldError.checkNotNull(
                lang, r'DocLanguageModel', 'lang'),
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'DocLanguageModel', 'label'));
    replace(_$result);
    return _$result;
  }
}

class _$PageModel extends PageModel {
  @override
  final String? coverImage;
  @override
  final String? coverBackground;
  @override
  final MenuItemModel label;
  @override
  final BuiltList<MenuItemModel> items;
  @override
  final String? file;

  factory _$PageModel([void Function(PageModelBuilder)? updates]) =>
      (new PageModelBuilder()..update(updates))._build();

  _$PageModel._(
      {this.coverImage,
      this.coverBackground,
      required this.label,
      required this.items,
      this.file})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(label, r'PageModel', 'label');
    BuiltValueNullFieldError.checkNotNull(items, r'PageModel', 'items');
  }

  @override
  PageModel rebuild(void Function(PageModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PageModelBuilder toBuilder() => new PageModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageModel &&
        coverImage == other.coverImage &&
        coverBackground == other.coverBackground &&
        label == other.label &&
        items == other.items &&
        file == other.file;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, coverBackground.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, file.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PageModel')
          ..add('coverImage', coverImage)
          ..add('coverBackground', coverBackground)
          ..add('label', label)
          ..add('items', items)
          ..add('file', file))
        .toString();
  }
}

class PageModelBuilder implements Builder<PageModel, PageModelBuilder> {
  _$PageModel? _$v;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  String? _coverBackground;
  String? get coverBackground => _$this._coverBackground;
  set coverBackground(String? coverBackground) =>
      _$this._coverBackground = coverBackground;

  MenuItemModelBuilder? _label;
  MenuItemModelBuilder get label =>
      _$this._label ??= new MenuItemModelBuilder();
  set label(MenuItemModelBuilder? label) => _$this._label = label;

  ListBuilder<MenuItemModel>? _items;
  ListBuilder<MenuItemModel> get items =>
      _$this._items ??= new ListBuilder<MenuItemModel>();
  set items(ListBuilder<MenuItemModel>? items) => _$this._items = items;

  String? _file;
  String? get file => _$this._file;
  set file(String? file) => _$this._file = file;

  PageModelBuilder() {
    PageModel._defaultValue(this);
  }

  PageModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _coverImage = $v.coverImage;
      _coverBackground = $v.coverBackground;
      _label = $v.label.toBuilder();
      _items = $v.items.toBuilder();
      _file = $v.file;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PageModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PageModel;
  }

  @override
  void update(void Function(PageModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageModel build() => _build();

  _$PageModel _build() {
    _$PageModel _$result;
    try {
      _$result = _$v ??
          new _$PageModel._(
              coverImage: coverImage,
              coverBackground: coverBackground,
              label: label.build(),
              items: items.build(),
              file: file);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'label';
        label.build();
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PageModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$MenuItemModel extends MenuItemModel {
  @override
  final String icon;
  @override
  final String label;
  @override
  final String segment;
  @override
  final String fragment;

  factory _$MenuItemModel([void Function(MenuItemModelBuilder)? updates]) =>
      (new MenuItemModelBuilder()..update(updates))._build();

  _$MenuItemModel._(
      {required this.icon,
      required this.label,
      required this.segment,
      required this.fragment})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(icon, r'MenuItemModel', 'icon');
    BuiltValueNullFieldError.checkNotNull(label, r'MenuItemModel', 'label');
    BuiltValueNullFieldError.checkNotNull(segment, r'MenuItemModel', 'segment');
    BuiltValueNullFieldError.checkNotNull(
        fragment, r'MenuItemModel', 'fragment');
  }

  @override
  MenuItemModel rebuild(void Function(MenuItemModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MenuItemModelBuilder toBuilder() => new MenuItemModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MenuItemModel &&
        icon == other.icon &&
        label == other.label &&
        segment == other.segment &&
        fragment == other.fragment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, segment.hashCode);
    _$hash = $jc(_$hash, fragment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MenuItemModel')
          ..add('icon', icon)
          ..add('label', label)
          ..add('segment', segment)
          ..add('fragment', fragment))
        .toString();
  }
}

class MenuItemModelBuilder
    implements Builder<MenuItemModel, MenuItemModelBuilder> {
  _$MenuItemModel? _$v;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _segment;
  String? get segment => _$this._segment;
  set segment(String? segment) => _$this._segment = segment;

  String? _fragment;
  String? get fragment => _$this._fragment;
  set fragment(String? fragment) => _$this._fragment = fragment;

  MenuItemModelBuilder() {
    MenuItemModel._defaultValue(this);
  }

  MenuItemModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _icon = $v.icon;
      _label = $v.label;
      _segment = $v.segment;
      _fragment = $v.fragment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MenuItemModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MenuItemModel;
  }

  @override
  void update(void Function(MenuItemModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MenuItemModel build() => _build();

  _$MenuItemModel _build() {
    final _$result = _$v ??
        new _$MenuItemModel._(
            icon: BuiltValueNullFieldError.checkNotNull(
                icon, r'MenuItemModel', 'icon'),
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'MenuItemModel', 'label'),
            segment: BuiltValueNullFieldError.checkNotNull(
                segment, r'MenuItemModel', 'segment'),
            fragment: BuiltValueNullFieldError.checkNotNull(
                fragment, r'MenuItemModel', 'fragment'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

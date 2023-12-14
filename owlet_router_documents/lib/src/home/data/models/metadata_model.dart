/*
 Created by Thanh Son on 01/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../../domain/interfaces/metadata_interface.dart';

part 'metadata_model.g.dart';

@SerializersFor([
  MetaDataModel,
  RepoMetaDataModel,
  DocLanguageModel,
  PageModel,
  MenuItemModel,
  DocumentMetaDataModel,
  MenuItemInterface
])
final Serializers _serializers =
    (_$_serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

abstract class MetaDataModel
    implements MetaDataInterface, Built<MetaDataModel, MetaDataModelBuilder> {
  factory MetaDataModel([void Function(MetaDataModelBuilder) updates]) =
      _$MetaDataModel;

  const MetaDataModel._();

  @override
  BuiltList<RepoMetaDataModel> get repo;

  @BuiltValueField(wireName: 'doc-languages')
  @override
  BuiltList<DocLanguageModel> get docLanguages;

  @BuiltValueField(wireName: 'home-page')
  @override
  PageModel get homePage;

  @override
  BuiltList<PageModel> get pages;

  static MetaDataModel fromJson(Map<String, dynamic> json) =>
      _serializers.deserializeWith(MetaDataModel.serializer, json)!;

  Map<String, dynamic> toJson() =>
      _serializers.serializeWith(MetaDataModel.serializer, this)
          as Map<String, dynamic>;

  static Serializer<MetaDataModel> get serializer => _$metaDataModelSerializer;
}

abstract class RepoMetaDataModel
    implements
        RepoMetaDataInterface,
        Built<RepoMetaDataModel, RepoMetaDataModelBuilder> {
  factory RepoMetaDataModel([void Function(RepoMetaDataModelBuilder) updates]) =
      _$RepoMetaDataModel;

  const RepoMetaDataModel._();

  static RepoMetaDataModel fromJson(Map<String, dynamic> json) =>
      _serializers.deserializeWith(RepoMetaDataModel.serializer, json)!;

  Map<String, dynamic> toJson() =>
      _serializers.serializeWith(RepoMetaDataModel.serializer, this)
          as Map<String, dynamic>;

  static Serializer<RepoMetaDataModel> get serializer =>
      _$repoMetaDataModelSerializer;
}

abstract class DocLanguageModel
    implements
        DocLanguageInterface,
        Built<DocLanguageModel, DocLanguageModelBuilder> {
  factory DocLanguageModel([void Function(DocLanguageModelBuilder) updates]) =
      _$DocLanguageModel;

  const DocLanguageModel._();

  static DocLanguageModel fromJson(Map<String, dynamic> json) =>
      _serializers.deserializeWith(DocLanguageModel.serializer, json)!;

  Map<String, dynamic> toJson() =>
      _serializers.serializeWith(DocLanguageModel.serializer, this)
          as Map<String, dynamic>;

  static Serializer<DocLanguageModel> get serializer =>
      _$docLanguageModelSerializer;
}

abstract class PageModel
    implements PageInterface, Built<PageModel, PageModelBuilder> {
  factory PageModel([void Function(PageModelBuilder) updates]) = _$PageModel;

  const PageModel._();

  @BuiltValueField(wireName: 'cover-image')
  @override
  String? get coverImage;

  @BuiltValueField(wireName: 'cover-background')
  @override
  String? get coverBackground;

  @BuiltValueField(wireName: 'menu-item')
  @override
  MenuItemModel get menuItem;

  @override
  BuiltList<DocumentMetaDataModel> get data;

  static PageModel fromJson(Map<String, dynamic> json) =>
      _serializers.deserializeWith(PageModel.serializer, json)!;

  Map<String, dynamic> toJson() =>
      _serializers.serializeWith(PageModel.serializer, this)
          as Map<String, dynamic>;

  static Serializer<PageModel> get serializer => _$pageModelSerializer;
}

abstract class MenuItemModel
    implements MenuItemInterface, Built<MenuItemModel, MenuItemModelBuilder> {
  factory MenuItemModel([void Function(MenuItemModelBuilder) updates]) =
      _$MenuItemModel;

  const MenuItemModel._();

  static MenuItemModel fromJson(Map<String, dynamic> json) =>
      _serializers.deserializeWith(MenuItemModel.serializer, json)!;

  Map<String, dynamic> toJson() =>
      _serializers.serializeWith(MenuItemModel.serializer, this)
          as Map<String, dynamic>;

  static Serializer<MenuItemModel> get serializer => _$menuItemModelSerializer;
}

abstract class DocumentMetaDataModel
    implements
        DocumentMetaDataInterface,
        Built<DocumentMetaDataModel, DocumentMetaDataModelBuilder> {
  factory DocumentMetaDataModel(
          [void Function(DocumentMetaDataModelBuilder) updates]) =
      _$DocumentMetaDataModel;

  const DocumentMetaDataModel._();

  static DocumentMetaDataModel fromJson(Map<String, dynamic> json) =>
      _serializers.deserializeWith(DocumentMetaDataModel.serializer, json)!;

  Map<String, dynamic> toJson() =>
      _serializers.serializeWith(DocumentMetaDataModel.serializer, this)
          as Map<String, dynamic>;

  static Serializer<DocumentMetaDataModel> get serializer =>
      _$documentMetaDataModelSerializer;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../src/home/data/document_datasource.dart' as _i3;
import '../src/home/domain/usecases/content_usecase.dart' as _i7;
import '../src/home/domain/usecases/metadata_usecase.dart' as _i4;
import '../src/profile/data/profile_datasource.dart' as _i5;
import '../src/profile/domain/usecases/profile_usecase.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.DocumentDatasource>(() => _i3.DocumentDatasource());
    gh.lazySingleton<_i4.MetaDataUseCase>(
        () => _i4.MetaDataUseCase(gh<_i3.DocumentDatasource>()));
    gh.lazySingleton<_i5.ProfileDataSource>(() => _i5.ProfileDataSource());
    gh.lazySingleton<_i6.ProfileUseCase>(
        () => _i6.ProfileUseCase(gh<_i5.ProfileDataSource>()));
    gh.lazySingleton<_i7.ContentUseCase>(
        () => _i7.ContentUseCase(gh<_i3.DocumentDatasource>()));
    return this;
  }
}

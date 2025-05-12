// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:absence_tracker_flutter/core/usecase/usecase.dart' as _i142;
import 'package:absence_tracker_flutter/presentation/cubit/theme/theme_cubit.dart'
    as _i1073;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i142.NoParams>(() => const _i142.NoParams());
    gh.factory<_i1073.ThemeCubit>(() => _i1073.ThemeCubit());
    return this;
  }
}

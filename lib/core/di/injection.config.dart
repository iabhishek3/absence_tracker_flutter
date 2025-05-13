// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:absence_tracker_flutter/core/usecase/usecase.dart' as _i142;
import 'package:absence_tracker_flutter/data/datasources/absence_local_data_source.dart'
    as _i566;
import 'package:absence_tracker_flutter/data/datasources/absence_remote_data_source.dart'
    as _i970;
import 'package:absence_tracker_flutter/data/repositories/absence_repository_impl.dart'
    as _i607;
import 'package:absence_tracker_flutter/domain/repositories/absence_repository.dart'
    as _i909;
import 'package:absence_tracker_flutter/domain/usecases/get_absences.dart'
    as _i679;
import 'package:absence_tracker_flutter/presentation/cubit/absence/absence_cubit.dart'
    as _i880;
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
    gh.factory<_i970.AbsenceRemoteDataSource>(
        () => _i970.AbsenceRemoteDataSourceImpl());
    gh.factory<_i566.AbsenceLocalDataSource>(
        () => _i566.AbsenceLocalDataSourceImpl());
    gh.factory<_i909.AbsenceRepository>(() => _i607.AbsenceRepositoryImpl(
        remoteDataSource: gh<_i970.AbsenceRemoteDataSource>()));
    gh.factory<_i679.GetAbsences>(
        () => _i679.GetAbsences(gh<_i909.AbsenceRepository>()));
    gh.factory<_i880.AbsenceCubit>(
        () => _i880.AbsenceCubit(gh<_i679.GetAbsences>()));
    return this;
  }
}

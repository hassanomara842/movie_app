// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_app/api/api_manager.dart' as _i1065;
import 'package:movie_app/cubit/register_cubit.dart' as _i4;
import 'package:movie_app/domain/repositories/auth_repository.dart' as _i932;
import 'package:movie_app/domain/repositories/auth_repository_impl.dart'
    as _i733;
import 'package:movie_app/domain/usecases/register_usecase.dart' as _i584;

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
    gh.singleton<_i1065.ApiManager>(() => _i1065.ApiManager());
    gh.factory<_i932.AuthRepository>(
        () => _i733.AuthRepositoryImpl(gh<_i1065.ApiManager>()));
    gh.factory<_i584.RegisterUseCase>(
        () => _i584.RegisterUseCase(gh<_i932.AuthRepository>()));
    gh.factory<_i4.RegisterCubit>(
        () => _i4.RegisterCubit(gh<_i584.RegisterUseCase>()));
    return this;
  }
}

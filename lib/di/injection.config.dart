// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_app/api/api_manager.dart' as _i1065;
import 'package:movie_app/core/network/connectivity_service.dart' as _i175;
import 'package:movie_app/cubit/auth_cubit.dart' as _i43;
import 'package:movie_app/cubit/profile_cubit.dart' as _i574;
import 'package:movie_app/cubit/update_profile_cubit.dart' as _i140;
import 'package:movie_app/data/local/movies_hive_local_data_source_impl.dart'
    as _i432;
import 'package:movie_app/data/local/movies_local_data_source.dart' as _i1034;
import 'package:movie_app/di/firebase_module.dart' as _i639;
import 'package:movie_app/di/third_party_module.dart' as _i719;
import 'package:movie_app/domain/datasource/auth_remote_data_source.dart'
    as _i306;
import 'package:movie_app/domain/datasource/auth_remote_source_data_impl.dart'
    as _i734;
import 'package:movie_app/domain/repositories/auth_repository.dart' as _i932;
import 'package:movie_app/domain/repositories/auth_repository_impl.dart'
    as _i733;
import 'package:movie_app/domain/repositories/movies_repository.dart' as _i730;
import 'package:movie_app/domain/repositories/movies_repository_impl.dart'
    as _i738;
import 'package:movie_app/domain/usecases/delete_account_usecase.dart' as _i566;
import 'package:movie_app/domain/usecases/get_user_profile_usecase.dart'
    as _i467;
import 'package:movie_app/domain/usecases/google_signin_usecase.dart' as _i983;
import 'package:movie_app/domain/usecases/login_usecase.dart' as _i639;
import 'package:movie_app/domain/usecases/register_usecase.dart' as _i584;
import 'package:movie_app/domain/usecases/reset_password_usecase.dart' as _i273;
import 'package:movie_app/domain/usecases/update_profile_usecase.dart' as _i339;
import 'package:movie_app/home_layout/cubit/home_layout_cubit.dart' as _i115;
import 'package:movie_app/home_layout/tabs/home_tab/cubit/home_tab_cubit.dart'
    as _i418;
import 'package:movie_app/home_layout/tabs/movie_details/cubit/movie_details_cubit.dart'
    as _i163;
import 'package:movie_app/home_layout/tabs/search_tab/cubit/search_tab_cubit.dart'
    as _i750;

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
    final firebaseModule = _$FirebaseModule();
    final thirdPartyModule = _$ThirdPartyModule();
    gh.factory<_i115.HomeLayoutCubit>(() => _i115.HomeLayoutCubit());
    gh.factory<_i163.MovieDetailsCubit>(() => _i163.MovieDetailsCubit());
    gh.factory<_i750.SearchTabCubit>(() => _i750.SearchTabCubit());
    gh.singleton<_i1065.ApiManager>(() => _i1065.ApiManager());
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.lazySingleton<_i895.Connectivity>(() => thirdPartyModule.connectivity);
    gh.lazySingleton<_i1034.MoviesLocalDataSource>(
        () => _i432.MoviesHiveLocalDataSourceImpl());
    gh.lazySingleton<_i175.ConnectivityService>(
        () => _i175.ConnectivityServiceImpl(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i306.AuthRemoteDataSource>(
        () => _i734.AuthRemoteDataSourceImpl(
              firebaseAuth: gh<_i59.FirebaseAuth>(),
              firestore: gh<_i974.FirebaseFirestore>(),
              googleSignIn: gh<_i116.GoogleSignIn>(),
            ));
    gh.factory<_i932.AuthRepository>(() => _i733.AuthRepositoryImpl(
          gh<_i1065.ApiManager>(),
          gh<_i306.AuthRemoteDataSource>(),
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.lazySingleton<_i730.MoviesRepository>(() => _i738.MoviesRepositoryImpl(
          gh<_i175.ConnectivityService>(),
          gh<_i1034.MoviesLocalDataSource>(),
        ));
    gh.factory<_i566.DeleteAccountUseCase>(
        () => _i566.DeleteAccountUseCase(gh<_i932.AuthRepository>()));
    gh.factory<_i467.GetUserProfileUseCase>(
        () => _i467.GetUserProfileUseCase(gh<_i932.AuthRepository>()));
    gh.factory<_i983.GoogleSignInUseCase>(
        () => _i983.GoogleSignInUseCase(gh<_i932.AuthRepository>()));
    gh.factory<_i273.ResetPasswordUseCase>(
        () => _i273.ResetPasswordUseCase(gh<_i932.AuthRepository>()));
    gh.factory<_i339.UpdateProfileUseCase>(
        () => _i339.UpdateProfileUseCase(gh<_i932.AuthRepository>()));
    gh.lazySingleton<_i639.LoginUseCase>(
        () => _i639.LoginUseCase(gh<_i932.AuthRepository>()));
    gh.lazySingleton<_i584.RegisterUseCase>(
        () => _i584.RegisterUseCase(gh<_i932.AuthRepository>()));
    gh.factory<_i574.ProfileCubit>(
        () => _i574.ProfileCubit(gh<_i467.GetUserProfileUseCase>()));
    gh.factory<_i418.HomeTabCubit>(
        () => _i418.HomeTabCubit(gh<_i730.MoviesRepository>()));
    gh.factory<_i140.UpdateProfileCubit>(() => _i140.UpdateProfileCubit(
          gh<_i339.UpdateProfileUseCase>(),
          gh<_i566.DeleteAccountUseCase>(),
        ));
    gh.factory<_i43.AuthCubit>(() => _i43.AuthCubit(
          loginUseCase: gh<_i639.LoginUseCase>(),
          googleSignInUseCase: gh<_i983.GoogleSignInUseCase>(),
          registerUseCase: gh<_i584.RegisterUseCase>(),
          resetPasswordUseCase: gh<_i273.ResetPasswordUseCase>(),
        ));
    return this;
  }
}

class _$FirebaseModule extends _i639.FirebaseModule {}

class _$ThirdPartyModule extends _i719.ThirdPartyModule {}

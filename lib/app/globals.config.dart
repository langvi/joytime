// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../bloc/common/common_cubit.dart' as _i8;
import '../data/api/auth_api_service.dart' as _i5;
import '../data/di/di.dart' as _i14;
import '../data/preference/app_preferences.dart' as _i6;
import '../data/repository/auth_repository.dart' as _i7;
import '../navigation/app_navigator.dart' as _i12;
import '../navigation/app_navigator_iml.dart' as _i13;
import '../routes/app_routes.dart' as _i4;
import '../ui/home/cubit/home_cubit.dart' as _i9;
import '../ui/sign_in/cubit/sign_in_cubit.dart' as _i11;
import 'app_cubit.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final serviceModule = _$ServiceModule();
    gh.factory<_i3.AppCubit>(() => _i3.AppCubit());
    gh.lazySingleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.lazySingleton<_i5.AuthApiService>(
        () => _i5.AuthApiService(gh<_i6.AppPreferences>()));
    gh.lazySingleton<_i7.AuthRepository>(() => _i7.AuthRepository(
          gh<_i6.AppPreferences>(),
          gh<_i5.AuthApiService>(),
        ));
    gh.factory<_i8.CommonCubit>(() => _i8.CommonCubit());
    gh.factory<_i9.HomeCubit>(() => _i9.HomeCubit());
    await gh.factoryAsync<_i10.SharedPreferences>(
      () => serviceModule.prefs,
      preResolve: true,
    );
    gh.factory<_i11.SignInCubit>(
        () => _i11.SignInCubit(gh<_i7.AuthRepository>()));
    gh.lazySingleton<_i12.AppNavigator>(
        () => _i13.AppNavigatorImpl(gh<_i4.AppRouter>()));
    return this;
  }
}

class _$ServiceModule extends _i14.ServiceModule {}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../bloc/common/common_cubit.dart' as _i9;
import '../data/api/auth_api_service.dart' as _i6;
import '../data/di/di.dart' as _i15;
import '../data/storage/app_storage.dart' as _i7;
import '../data/repository/auth_repository.dart' as _i8;
import '../navigation/app_navigator.dart' as _i13;
import '../navigation/app_navigator_iml.dart' as _i14;
import '../navigation/app_poup.dart' as _i4;
import '../routes/app_routes.dart' as _i5;
import '../ui/home/cubit/home_cubit.dart' as _i10;
import '../ui/sign_in/cubit/sign_in_cubit.dart' as _i12;
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
    gh.lazySingleton<_i4.AppPoup>(() => _i4.AppPoup());
    gh.lazySingleton<_i5.AppRouter>(() => _i5.AppRouter());
    gh.lazySingleton<_i6.AuthApiService>(
        () => _i6.AuthApiService(gh<_i7.AppStorage>()));
    gh.lazySingleton<_i8.AuthRepository>(() => _i8.AuthRepository(
          gh<_i7.AppStorage>(),
          gh<_i6.AuthApiService>(),
        ));
    gh.factory<_i9.CommonCubit>(() => _i9.CommonCubit());
    gh.factory<_i10.HomeCubit>(() => _i10.HomeCubit());
    await gh.factoryAsync<_i11.SharedPreferences>(
      () => serviceModule.prefs,
      preResolve: true,
    );
    gh.factory<_i12.SignInCubit>(
        () => _i12.SignInCubit(gh<_i8.AuthRepository>()));
    gh.lazySingleton<_i13.AppNavigator>(() => _i14.AppNavigatorImpl(
          gh<_i5.AppRouter>(),
          gh<_i4.AppPoup>(),
        ));
    return this;
  }
}

class _$ServiceModule extends _i15.ServiceModule {}

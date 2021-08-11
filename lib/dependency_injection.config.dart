// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/services/api_service.dart' as _i4;
import 'data/services/profile_service.dart' as _i5;
import 'presentation/services/authorization_service.dart' as _i3;
import 'presentation/services/theme_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthorizationService>(() => _i3.AuthorizationService());
  gh.singleton<_i4.ApiService>(_i4.ApiService());
  gh.singleton<_i5.ProfileService>(_i5.ProfileService());
  gh.singleton<_i6.ThemeService>(_i6.ThemeService());
  return get;
}

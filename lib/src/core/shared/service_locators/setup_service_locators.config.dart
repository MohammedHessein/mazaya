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

import '../../../features/auth/login/cubits/login_cubit.dart' as _i668;
import '../../../features/categories/presentation/cubits/categories_cubit.dart'
    as _i40;
import '../../../features/change_password/presentation/cubits/change_password_cubit.dart'
    as _i778;
import '../../../features/coupons/presentation/cubits/coupons_cubit.dart'
    as _i1022;
import '../../../features/favourite/presentation/imports/view_imports.dart'
    as _i203;
import '../../../features/home/presentation/cubits/home_cubit.dart' as _i246;
import '../../../features/more/presentation/cubits/logout_cubit.dart' as _i577;
import '../../../features/more/presentation/cubits/more_delete_account_cubit.dart'
    as _i871;
import '../../../features/notifications/presentation/cubits/unread_notification_count_cubit.dart'
    as _i857;
import '../../../features/notifications/presentation/imports/view_imports.dart'
    as _i980;
import '../../../features/settings/presentation/imports/view_imports.dart'
    as _i972;
import '../../../features/static_pages/presentation/imports/view_imports.dart'
    as _i816;
import '../../../features/used_coupons/presentation/imports/view_imports.dart'
    as _i519;
import '../../base_crud/code/data/base_data_imports.dart' as _i241;
import '../../base_crud/code/domain/base_domain_imports.dart' as _i267;
import '../../base_crud/code/domain/repositories/base_repository.dart' as _i618;
import '../../base_crud/code/domain/usecases/base_crud.dart' as _i687;
import '../../base_crud/code/domain/usecases/get_base_id_and_name_usecase.dart'
    as _i763;
import '../../network/dio_service.dart' as _i37;
import '../../network/network_service.dart' as _i632;
import '../cubits/user_cubit/user_cubit.dart' as _i996;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i668.LoginCubit>(() => _i668.LoginCubit());
    gh.factory<_i40.CategoriesCubit>(() => _i40.CategoriesCubit());
    gh.factory<_i778.ChangePasswordCubit>(() => _i778.ChangePasswordCubit());
    gh.factory<_i1022.CouponsCubit>(() => _i1022.CouponsCubit());
    gh.factory<_i203.FavouriteCubit>(() => _i203.FavouriteCubit());
    gh.factory<_i246.HomeCubit>(() => _i246.HomeCubit());
    gh.factory<_i577.LogoutCubit>(() => _i577.LogoutCubit());
    gh.factory<_i871.MoreDeleteAccountCubit>(
      () => _i871.MoreDeleteAccountCubit(),
    );
    gh.factory<_i980.NotificationsCubit>(() => _i980.NotificationsCubit());
    gh.factory<_i972.LangCubit>(() => _i972.LangCubit());
    gh.factory<_i972.NotifyCubit>(() => _i972.NotifyCubit());
    gh.factory<_i972.DeleteAccountCubit>(() => _i972.DeleteAccountCubit());
    gh.factory<_i816.StaticPagesCubit>(() => _i816.StaticPagesCubit());
    gh.factory<_i519.UsedCouponsCubit>(() => _i519.UsedCouponsCubit());
    gh.lazySingleton<_i996.UserCubit>(() => _i996.UserCubit());
    gh.lazySingleton<_i857.UnreadNotificationCountCubit>(
      () => _i857.UnreadNotificationCountCubit(),
    );
    gh.lazySingleton<_i632.NetworkService>(() => _i37.DioService());
    gh.lazySingleton<_i241.BaseRemoteDataSource>(
      () => _i241.BaseRemoteDataSourceImpl(
        dioService: gh<_i632.NetworkService>(),
      ),
    );
    gh.lazySingleton<_i267.BaseRepository>(
      () => _i241.BaseRepositoryImpl(
        baseRemoteDataSource: gh<_i241.BaseRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i687.BaseCrudUseCase>(
      () => _i687.BaseCrudUseCase(repository: gh<_i618.BaseRepository>()),
    );
    gh.lazySingleton<_i763.GetBaseEntityUseCase>(
      () => _i763.GetBaseEntityUseCase(repository: gh<_i618.BaseRepository>()),
    );
    return this;
  }
}

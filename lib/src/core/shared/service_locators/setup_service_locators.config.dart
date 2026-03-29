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
import '../../../features/complains/presentation/imports/view_imports.dart'
    as _i434;
import '../../../features/contact_us/presentation/imports/contact_us_imports.dart'
    as _i95;
import '../../../features/coupons/presentation/cubits/coupons_cubit.dart'
    as _i1022;
import '../../../features/faqs/presentation/imports/view_imports.dart' as _i901;
import '../../../features/more/presentation/imports/view_imports.dart' as _i964;
import '../../../features/notifications/presentation/cubits/unread_notification_count_cubit.dart'
    as _i857;
import '../../../features/notifications/presentation/imports/view_imports.dart'
    as _i980;
import '../../../features/settings/presentation/imports/view_imports.dart'
    as _i972;
import '../../../features/static_pages/presentation/imports/view_imports.dart'
    as _i816;
import '../../../features/user_profile/presentation/imports/view_imports.dart'
    as _i360;
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
    gh.factory<_i434.AddComplainCubit>(() => _i434.AddComplainCubit());
    gh.factory<_i434.ComplainsDetailsCubit>(
      () => _i434.ComplainsDetailsCubit(),
    );
    gh.factory<_i434.ComplainsCubit>(() => _i434.ComplainsCubit());
    gh.factory<_i95.ContactUsCubit>(() => _i95.ContactUsCubit());
    gh.factory<_i1022.CouponsCubit>(() => _i1022.CouponsCubit());
    gh.factory<_i901.FaqsCubit>(() => _i901.FaqsCubit());
    gh.factory<_i964.LogOutCubit>(() => _i964.LogOutCubit());
    gh.factory<_i980.NotificationsCubit>(() => _i980.NotificationsCubit());
    gh.factory<_i972.LangCubit>(() => _i972.LangCubit());
    gh.factory<_i972.NotifyCubit>(() => _i972.NotifyCubit());
    gh.factory<_i972.DeleteAccountCubit>(() => _i972.DeleteAccountCubit());
    gh.factory<_i816.StaticPagesCubit>(() => _i816.StaticPagesCubit());
    gh.factory<_i360.UserProfileCubit>(() => _i360.UserProfileCubit());
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

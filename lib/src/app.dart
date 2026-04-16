
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/config/themes/app_theme.dart';
import 'package:mazaya/src/core/helpers/loading_manager.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/navigation/route_generator.dart';
import 'package:mazaya/src/core/network/un_authenticated_interceptor.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/shared/route_observer.dart';
import 'package:mazaya/src/core/utils/favorite_manager.dart';
import 'package:mazaya/src/core/widgets/handling_views/no_internet_view.dart';
import 'package:mazaya/src/core/widgets/un_autheticated/unauthenticated_bottomsheet.dart';
import 'package:mazaya/src/features/intro/presentation/imports/view_imports.dart';
import 'package:mazaya/src/features/notifications/presentation/imports/view_imports.dart';

class MazayaApp extends StatefulWidget {
  final Widget? home;
  const MazayaApp({super.key, this.home});

  @override
  State<MazayaApp> createState() => _MazayaAppState();
}

class _MazayaAppState extends State<MazayaApp> {
  @override
  void initState() {
    super.initState();
    _addUnAuthenticatedListener();
    // UserCubit init is now handled in main.dart if needed,
    // or we can keep it here for safety, but we'll use the result from main.
  }

  void _addUnAuthenticatedListener() {
    UnAuthenticatedInterceptor.instance.addListener((bool isBlocked) {
      UnAuthenticatedBottomSheet.show(isBlocked: isBlocked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(ScreenSizes.width, ScreenSizes.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => injector<FavoriteManager>(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: injector<UserCubit>()),
              BlocProvider.value(value: injector<NotificationCountCubit>()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: ConstantManager.appName,
              localizationsDelegates: [
                flc.CountryLocalizations.delegate,
                ...context.localizationDelegates,
              ],
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              navigatorKey: Go.navigatorKey,
              onGenerateRoute: RouterGenerator.getRoute,
              home: widget.home ?? const IntroScreen(),
              navigatorObservers: [AppNavigationObserver()],
              theme: AppTheme.light,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: OfflineBuilder(
                    connectivityBuilder: (context, connectivity, _) {
                      final bool isNotConnected =
                          connectivity.isEmpty ||
                          connectivity.contains(ConnectivityResult.none);

                      return Stack(
                        children: [
                          FullScreenLoadingManager(
                            child: SafeArea(top: false, child: child!),
                          ),
                          if (isNotConnected) const NoInternetView(),
                        ],
                      );
                    },
                    builder: (context) => const SizedBox.shrink(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

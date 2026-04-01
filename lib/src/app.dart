import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/features/intro/presentation/imports/view_imports.dart';

import 'config/res/config_imports.dart';
import 'config/themes/app_theme.dart';
import 'core/helpers/loading_manager.dart';
import 'core/navigation/navigator.dart';
import 'core/navigation/route_generator.dart';
import 'core/network/un_authenticated_interceptor.dart';
import 'core/shared/cubits/user_cubit/user_cubit.dart';
import 'core/shared/route_observer.dart';
import 'core/widgets/handling_views/offline_widget.dart';
import 'core/widgets/un_autheticated/unauthenticated_bottomsheet.dart';

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
        return BlocProvider(
          create: (context) => injector<UserCubit>(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: ConstantManager.appName,
            localizationsDelegates: context.localizationDelegates,
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
                child: OfflineWidget(
                  child: FullScreenLoadingManager(
                    child: Platform.isAndroid
                        ? SafeArea(top: false, child: child!)
                        : child!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

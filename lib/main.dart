import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/app.dart';
import 'src/config/language/languages.dart';
import 'src/config/res/config_imports.dart';
import 'src/core/helpers/helpers.dart';
import 'src/core/navigation/Constants/imports_constants.dart';
import 'src/core/navigation/go.dart';
import 'src/core/navigation/page_router/implementation/imports_page_router.dart';
import 'src/core/navigation/page_router/imports_page_router_builder.dart';
import 'src/core/helpers/cache_service.dart';
import 'src/core/network/backend_configuation.dart';
import 'src/core/shared/bloc_observer.dart';
import 'src/core/shared/service_locators/setup_service_locators.dart';
import 'src/core/widgets/handling_views/exeption_view.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(),
    EasyLocalization.ensureInitialized(), // Initialize localization
    CacheStorage.init(), // Initialize local cache
    ScreenUtil.ensureScreenSize(), // Initialize screen size utils
  ]);

  // Lock the app orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Setup dependency injection (register services, repositories, etc.)
  setUpServiceLocator();

  // Configure backend type (e.g. ASP.NET backend)
  BackendConfiguation.setBackendType(BackendType.php);

  // Initialize page router with custom transition animations
  PageRouterBuilder().initAppRouter(
    config: PlatformConfig(
      android: CustomPageRouterCreator(
        parentTransition: TransitionType.fade, // Transition type: fade
        parentOptions: const FadeAnimationOptions(
          duration: Duration(milliseconds: 300), // Transition duration
        ),
      ),
    ),
  );

  // Restart animations when hot reload happens (developer experience)
  Animate.restartOnHotReload = true;

  // In release mode → replace Flutter’s red error screen with custom widget
  if (kReleaseMode) {
    ErrorWidget.builder = (FlutterErrorDetails details) =>
        const ExceptionView();
  }

  // In debug mode → enable EasyLocalization logs for error + warning
  if (kDebugMode) {
    EasyLocalization.logger.enableLevels = [
      LevelMessages.error,
      LevelMessages.warning,
    ];
  }

  // Change status bar color globally at app start
  Helpers.changeStatusbarColor(statusBarColor: AppColors.white);

  // Run the actual app wrapped with EasyLocalization widget
  runApp(
    EasyLocalization(
      supportedLocales: Languages.supportLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: const MazayaApp(),
    ),
  );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/app.dart';
import 'src/config/language/languages.dart';
import 'src/core/helpers/helpers.dart';
import 'src/core/navigation/constants/imports_constants.dart';
import 'src/core/navigation/deep_link_service.dart';
import 'src/core/navigation/go.dart';
import 'src/core/navigation/page_router/implementation/imports_page_router.dart';
import 'src/core/navigation/page_router/imports_page_router_builder.dart';
import 'src/core/network/backend_configuation.dart';
import 'src/core/notification/notification_service.dart';
import 'src/core/shared/bloc_observer.dart';
import 'src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'src/core/shared/service_locators/setup_service_locators.dart';
import 'src/core/widgets/handling_views/exeption_view.dart';
import 'src/features/auth/login/imports/login_imports.dart';
import 'src/features/intro/presentation/imports/view_imports.dart';
import 'src/features/location/imports/location_imports.dart';

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
          duration: Duration(milliseconds: 500), // Transition duration
        ),
      ),
    ),
  );

  // Initialize Deep Linking
  DeepLinkService.instance.init();

  // Restart animations when hot reload happens (developer experience)
  Animate.restartOnHotReload = true;

  // Initialize notifications early to fetch FCM token for login
  NotificationNavigator();
  injector<NotificationService>().setupNotifications();

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
  Helpers.changeStatusbarColor(statusBarColor: Colors.transparent);

  final bool isLoggedIn = await injector<UserCubit>().init();
  final bool sawOnboarding =
      CacheStorage.read(ConstantManager.sawOnboarding) ?? false;
  final bool selectedLocation =
      CacheStorage.read(ConstantManager.selectedLocation) ?? false;

  Widget initialScreen;
  if (!sawOnboarding) {
    initialScreen = const IntroScreen();
  } else if (!isLoggedIn) {
    initialScreen = const LoginScreen();
  } else if (!selectedLocation &&
      injector<UserCubit>().user.locationId == null) {
    initialScreen = const SelectLocationScreen();
  } else {
    initialScreen = const MainScreen();
  }

  // Run the actual app wrapped with EasyLocalization widget
  runApp(
    EasyLocalization(
      supportedLocales: Languages.supportLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('sv'),
      startLocale: const Locale('sv'),
      saveLocale: true,
      child: MazayaApp(home: initialScreen),
    ),
  );
}

part of '../imports/view_imports.dart';

class MainScreen extends StatefulWidget {
  final int initialTabIndex;
  const MainScreen({super.key, this.initialTabIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  late final MainParams params = MainParams(
    initialIndex: widget.initialTabIndex,
  );

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  void _initNotifications() {
    NotificationNavigator();
    injector<NotificationService>().setupNotifications();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return ValueListenableBuilder<int>(
      valueListenable: params.selectedIndexNotifier,
      builder: (context, value, child) {
        String title = '';

        if (value == 2) {
          return Scaffold(
            body: _MainBody(value),
            bottomNavigationBar: CustomNavigationBar(
              selectedIndex: value,
              onTabChange: (newIndex) => params.updateNavValue(newIndex),
              tabs: params.navTabs,
            ),
          );
        }

        ScaffoldHeaderType headerType;

        switch (value) {
          case 0:
            headerType = ScaffoldHeaderType.home;
            break;
          case 1:
            headerType = ScaffoldHeaderType.standard;
            title = LocaleKeys.couponsTitle;
            break;
          case 3:
            headerType = ScaffoldHeaderType.profile;
            break;
          default:
            headerType = ScaffoldHeaderType.home;
        }

        return DefaultScaffold(
          title: title,
          headerType: headerType,
          showBackButton: false,
          userName: 'محمد حسين',
          imageUrl: AppAssets.svg.baseSvg.profile.path,
          extendBody: true,
          body: _MainBody(value),
          bottomNavigationBar: CustomNavigationBar(
            selectedIndex: value,
            onTabChange: (newIndex) => params.updateNavValue(newIndex),
            tabs: params.navTabs,
          ),
        );
      },
    );
  }
}

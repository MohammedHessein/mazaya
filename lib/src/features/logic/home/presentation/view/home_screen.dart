part of '../imports/view_imports.dart';

class HomeScreen extends StatefulWidget {
  final int initialTabIndex;
  const HomeScreen({super.key, this.initialTabIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late final HomeParams params = HomeParams(
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
        return Scaffold(
          body: _HomeBody(value),
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

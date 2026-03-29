import 'package:injectable/injectable.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/network/network_service.dart';
import 'package:mazaya/src/core/notification/notification_service.dart';
import 'setup_service_locators.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void setUpServiceLocator() {
  injector.init();
  setUpGeneralDependencies();
  injector<NetworkService>().updateBaseUrl();
}

void setUpGeneralDependencies() {
  injector.registerFactory<NotificationService>(() => NotificationService());
}

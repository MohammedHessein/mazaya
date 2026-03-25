import 'package:injectable/injectable.dart';
import '../../../config/res/config_imports.dart';
import '../../notification/notification_service.dart';
import 'setup_service_locators.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void setUpServiceLocator() {
  injector.init();
  setUpGeneralDependencies();
}

void setUpGeneralDependencies() {
  injector.registerFactory<NotificationService>(() => NotificationService());
}

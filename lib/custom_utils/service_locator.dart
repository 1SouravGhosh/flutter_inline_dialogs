import 'package:get_it/get_it.dart';
import 'package:inline_dialogs/dialogs/service.dart';

GetIt locator = GetIt.instance;

void dialogSetupLocator() {
  locator.registerSingleton(DialogService());
}

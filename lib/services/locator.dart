import 'package:get_it/get_it.dart';
import 'package:trailerfilm_app/services/auth_repo.dart';
import 'package:trailerfilm_app/services/storage_repo.dart';
import 'package:trailerfilm_app/services/user_controller.dart';

final locator = GetIt.instance;

void setupServices() {
   locator.registerSingleton<AuthRepo>(AuthRepo());
   locator.registerSingleton<UserController>(UserController());
   locator.registerSingleton<StorageRepo>(StorageRepo());
}

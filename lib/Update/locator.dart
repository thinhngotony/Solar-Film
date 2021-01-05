import 'auth_repo.dart';
import 'user_controller.dart';
import 'package:get_it/get_it.dart';
import 'storage_repo.dart';

final locator = GetIt.instance;


void setupServices() {
   locator.registerSingleton<AuthRepo>(AuthRepo());
   locator.registerSingleton<UserController>(UserController());
   locator.registerSingleton<StorageRepo>(StorageRepo());

}

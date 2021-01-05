import 'dart:io';
import 'package:firebaseauth/Update/storage_repo.dart';
import 'user_model.dart';
import 'auth_repo.dart';
import 'locator.dart';
import 'package:get_it/get_it.dart';

class UserController {
  UserModel _currentUser;
  AuthRepo _authRepo = locator.get<AuthRepo>();
  Future init;

  UserController() {
    init = initUser();
  }

  Future<UserModel> initUser() async {
    _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  UserModel get currentUser => _currentUser;

  Future<void> uploadProfilePicture(File image) async{
    _currentUser.avatarUrl = await locator.get<StorageRepo>().uploadFile(image);
  }

}

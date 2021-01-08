import 'dart:io';
import 'package:trailerfilm_app/model/user_model.dart';
import 'package:trailerfilm_app/services/auth_repo.dart';
import 'package:trailerfilm_app/services/locator.dart';
import 'package:trailerfilm_app/services/storage_repo.dart';

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

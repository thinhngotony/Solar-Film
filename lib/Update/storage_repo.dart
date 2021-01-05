import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseauth/Update/auth_repo.dart';
import 'locator.dart';


class StorageRepo {
  FirebaseStorage storage = FirebaseStorage(storageBucket: "gs://login-new-b3ff7.appspot.com");

  AuthRepo _authRepo = locator.get<AuthRepo>();




Future<String> uploadFile(File file) async{
    var user = await _authRepo.getUser() ;
    var storageRef = storage.ref().child("user/profile/${user.uid}");
    var uploadTask = storageRef.putFile(file);
    var completeTask = await uploadTask.onComplete;
    String downUrl = await completeTask.ref.getDownloadURL();
    return downUrl;
  }

}
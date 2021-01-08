import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trailerfilm_app/model/profile.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference personal =
  FirebaseFirestore.instance.collection('personal');

  Future updateFavoriteMovies(String movie_id) async {
    return personal.doc(uid).collection('favorite')
        .doc(movie_id.toString())
        .set({});
  }

  Future deleteFavoriteMovies(String movie_id) async {
    return personal.doc(uid).collection('favorite')
        .doc(movie_id.toString())
        .delete();
  }

  Future updateUserProfile(String name, String email, String phone) async {
    return await personal.doc(uid).collection('profiles').doc('0').set({
      'name': name,
      'email': email,
      'phone': phone,
    });
  }

  Future deleteUserProfile() async {
    return await personal.doc(uid).collection('profiles').doc('0').delete();
  }

  Profile getProfile() {
    personal.doc(uid).collection('profiles').doc('0').get().then((value) {
      return Profile(
        name: value.data()['name'] ?? '',
        email: value.data()['email'] ?? '',
        phone: value.data()['phone'] ?? '',
      );
    });
  }

  List<String> getFavorite() {
    List<String> list;
    personal.doc(uid).collection('favorite').get().then((value) {
      value.docs.forEach((element) {
        list.add(element.id);
      });
    });
    return list;
  }
}

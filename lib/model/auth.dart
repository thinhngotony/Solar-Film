import 'dart:core';

class BaseAuth {
  final String userName;
  final String email;
  final String avatar;
  bool isLoggedin = false;
  
  BaseAuth(
    this.userName, 
    this.email, 
    this.avatar,
    this.isLoggedin,
  );
}


// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:trailerfilm_app/forgotpassword.dart';
import 'package:trailerfilm_app/screens/home_screen.dart';
import 'package:trailerfilm_app/signup.dart';
import 'package:trailerfilm_app/app.dart' as globals;
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

enum FormType {
  login,
  register
}

class _SignIn extends State<SignIn> {
  bool _obscureTextLogin = true;
  bool _isloggedIn = false;
  bool _isLoading = false;
  var profileData;
  Map user;

  String _email;
  String _userName = "Thien Nguyen";
  String _avatar;
  String _password;
  final formKey = new GlobalKey<FormState>();

  FormType _formType = FormType.login;

  
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is valid. Email $_email, password $_password');
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try{
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        print('Signed in: ${user.uid}');
      }
      catch(e) {
        print('Error: $e');
      }
    }
  }

  final facebooklogin = FacebookLogin();

  FocusNode myFocusNodeEmailLogin;
  FocusNode myFocusNodePasswordLogin;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      _isLoading = false;
      this._isloggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  Future<void> _logonwithfb() async {
    final result = await facebooklogin.logIn(['email']);
    switch( result.status){
      case FacebookLoginStatus.loggedIn:
        final token =result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = jsonDecode(graphResponse.body);
        print("show " + "${profile}");
        user = profile;
          // _avatar = profileData['picture']['data']['url'].toString();
          // _userName = profileData['name'].toString();
          // _isloggedIn =true;
          // print(_userName);
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isloggedIn = false;
        }
        );
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _isloggedIn = false;
        });
    }
  }

  Future<void> _logout(){
    facebooklogin.logOut();
    setState(() {
      _isloggedIn= false;
      globals.isLoggedIn = false;
    });
  }

  void initiateFacebookLogin() async {
    setState(() {
      _isLoading = true;
    });
    var facebookLoginResult = await facebooklogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');
        var profile = json.decode(graphResponse.body);
        onLoginStatusChanged(true, profileData: profile);
        _userName = profileData['name'];
        print("username " + "${_userName}");
        _avatar = profileData['picture']['data']['url'];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    final logo = Hero(
      tag: 'hero', 
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/image/uit-logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      focusNode: this.myFocusNodeEmailLogin,
      controller: this.loginEmailController,
      decoration: InputDecoration(
        hintText: 'Enter your email...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      onSaved: (value) => _email = value,
    );

    final password = TextFormField(
      focusNode: this.myFocusNodePasswordLogin,
      controller: this.loginPasswordController,
      obscureText: this._obscureTextLogin,
      decoration: InputDecoration(
        hintText: 'Enter your password...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: this._obscureTextLogin ? Colors.blue : Colors.grey,
          ),
          onPressed: this._toggleLogin,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      );
    
    final loginButton = new RaisedButton(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: const Text('Sign In'),
      textColor: Colors.white,
      color: Theme.of(context).accentColor,
      elevation: 10.0,
      splashColor: Colors.blueGrey,
      onPressed: validateAndSubmit,
      // onPressed: () {
      //   // Perform some action
      //   // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // },
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => ForgotPassword())
        );
      },
    );

    final registerLabel = FlatButton(
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => SignUp())
        );
      }, 
      // onPressed: moveToRegister,
      child: Text("Sign Up",
        style: TextStyle(color: Colors.blue),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 45.0),
            Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  email,
                  SizedBox(height: 5.0),
                  password,
                ],
              ),
            ),
            Container(
              alignment: Alignment(1.0, 0.0),
              child: forgotLabel,
            ),
            SizedBox(height: 15.0),
            loginButton,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account?"),
                registerLabel
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black54
                        ],
                        begin: const FractionalOffset(1.0, 1.0),
                        end: const FractionalOffset(0.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp
                      ),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text("Or",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontFamily: "WorkSansMedium"
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black54
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp
                      ),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, right: 40.0),
                  child: GestureDetector(
                    onTap: () {
                      _logonwithfb();
                      if (!_isloggedIn)
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
                        );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: new Icon(
                        FontAwesomeIcons.facebookF,
                        color: Color(0xFF0084ff),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      _logonwithfb();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => HomeScreen())
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: new Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xFF0084ff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


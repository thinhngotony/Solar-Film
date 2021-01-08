import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;
  String _email;
  String _password;

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController = new TextEditingController();

  void _toggleSignup() {
    setState(() {
    _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
    _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final logoUser = Hero(
      tag: 'hero', 
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/image/logo-user.png'),
      ),
    );

    final registerEmail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your email...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.email),
      ),
      onSaved: (value) => _email = value,
    );

    final registerUsername = TextFormField(
      focusNode: this.myFocusNodeName,
      controller: this.signupNameController,
      decoration: InputDecoration(
        hintText: 'Enter your email...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.person),
      ),
      
    );

    final registerPassword = TextFormField(
      obscureText: this._obscureTextSignup,
      decoration: InputDecoration(
        hintText: 'Enter your password...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: this._obscureTextSignup ? Colors.blue : Colors.grey,
          ),
          onPressed: this._toggleSignup,
        ),
      ),
      onSaved: (value) => _password = value,
    );

    final confirmPassword = TextFormField(
      decoration: InputDecoration(
        hintText: 'Comfirm your password...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: this._obscureTextSignup ? Colors.blue : Colors.grey,
          ),
          onPressed: this._toggleSignupConfirm,
        ),
      ),
    );

    final registerButton = new RaisedButton(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: const Text('Sign In'),
      textColor: Colors.white,
      color: Theme.of(context).accentColor,
      elevation: 10.0,
      splashColor: Colors.blueGrey,
      onPressed: () {
        // Perform some action
        FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      },
    );

    return new Scaffold(
      appBar: AppBar(
        title: new Text("Sign Up"),
        backgroundColor: Colors.transparent
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logoUser,
            SizedBox(height: 45.0),
            registerEmail,
            SizedBox(height: 10.0),
            registerUsername,
            SizedBox(height: 10.0),
            registerPassword,
            SizedBox(height: 10.0),
            confirmPassword,
            SizedBox(height: 15.0),
            registerButton,
          ],
        ),
      ),
    );
  }  
}
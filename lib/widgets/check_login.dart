import 'package:flutter/material.dart';
import 'package:trailerfilm_app/signin.dart';
import 'package:trailerfilm_app/widgets/user_profile.dart';
import 'package:trailerfilm_app/app.dart' as globals;

class CheckLogin extends StatefulWidget {
  @override
  _CheckLogin createState() => _CheckLogin();
}

class _CheckLogin extends State<CheckLogin> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: globals.isLoggedIn ? 
      UserProfile()
      : Column(
          children: [
            Text(
              'You are not logged in',
            ),
            ElevatedButton(
              onPressed: () {
              _navigateAndDisplaySelection(context);
            },
              child: Text('Log in'),
            ),
          ],
        ),
    );
  }
  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}
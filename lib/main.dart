import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trailerfilm_app/services/locator.dart';
import 'package:trailerfilm_app/theme/theme.dart' as theme;
import 'package:trailerfilm_app/widgets/login_page/login_page.dart';
import 'package:trailerfilm_app/widgets/login_page/profilepage.dart';

// void main() => runApp(MyApp());
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Auth Screen 1',
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primaryColor: theme.Colors.kPrimaryColor,
      //   scaffoldBackgroundColor: theme.Colors.kBackgroundColor,
      //   textTheme: TextTheme(
      //     display1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //     button: TextStyle(color: theme.Colors.kPrimaryColor),
      //     headline:
      //     TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      //   ),
      //   inputDecorationTheme: InputDecorationTheme(
      //     enabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(
      //         color: Colors.white.withOpacity(.2),
      //       ),
      //     ),
      //   ),
      // ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.Colors.kBackgroundColor,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/perosn.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "SOLARS FILM\n",
                        style: new TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "Where you can relax your mind!",
                        style: new TextStyle(
                          fontSize: 27.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 25),
                      padding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: theme.Colors.kPrimaryColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "GET STARTED",
                            style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Code cũ giao diện đăng nhập
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Firebase Authentication.'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//
//   final emailTextController = TextEditingController();
//   final passwordTextController = TextEditingController();
//
//   @override
//   void dispose() {
//     emailTextController.dispose();
//     passwordTextController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text(
//             widget.title,
//         ),
//
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               width: 360,
//               child: TextFormField(
//                 validator: (input) {
//                   if(input.isEmpty) {
//                     return 'Please type an email';
//                   }
//                 },
//                 decoration: InputDecoration(
//                     labelText: 'Email'
//                 ),
//                 controller: emailTextController,
//               ),
//             ),
//             SizedBox(
//               width: 360,
//               child: TextFormField(
//                 obscureText: true,
//                 validator: (input) {
//                   if(input.isEmpty) {
//                     return 'Please type an password';
//                   }
//                 },
//                 decoration: InputDecoration(
//                     labelText: 'Password'
//                 ),
//
//                 controller: passwordTextController,
//               ),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: 360,
//               child: RaisedButton(
//                 child: Row(
//                   children: <Widget>[
//                     Icon(Icons.mail, size: 30),
//                     Text(
//                       '  Sign up with Email',
//                       style: TextStyle(fontSize: 28),
//                     ),
//                   ],
//                 ),
//                 textColor: Colors.white,
//                 color: Colors.red[400],
//                 padding: EdgeInsets.all(10),
//                 onPressed: () {
//                   signUpWithMail();
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: 360,
//               child: RaisedButton(
//                 child: Row(
//                   children: <Widget>[
//                     Icon(Icons.thumb_up, size: 30),
//                     Text(
//                       '  Sign up with Facebook',
//                       style: TextStyle(fontSize: 28),
//                     ),
//                   ],
//                 ),
//                 textColor: Colors.white,
//                 color: Colors.blue[900],
//                 padding: EdgeInsets.all(10),
//                 onPressed: () {
//                   signUpWithFacebook();
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: 360,
//               child: RaisedButton(
//                 child: Row(
//                   children: <Widget>[
//                     Icon(Icons.toys, size: 30),
//                     Text(
//                       '  Sign up with Google',
//                       style: TextStyle(fontSize: 28),
//                     ),
//                   ],
//                 ),
//                 textColor: Colors.black,
//                 color: Colors.white,
//                 padding: EdgeInsets.all(10),
//                 onPressed: () {
//                   _googleSignUp();
//                 },
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _googleSignUp() async {
//     try {
//       final GoogleSignIn _googleSignIn = GoogleSignIn(
//         scopes: [
//           'email'
//         ],
//       );
//       final FirebaseAuth _auth = FirebaseAuth.instance;
//
//       final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.getCredential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
//       print("signed in " + user.displayName);
//       var x = user.displayName;
//       Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfilePage()));
//       CoolAlert.show(
//         context: context,
//         type: CoolAlertType.success,
//         text: "Đăng kí thành công tài khoản $x"
//             "\nĐang chuyển hướng để hoàn tất hồ sơ!",
//       );
//       return user;
//     }catch (e) {
//       print(e.message);
//     }
//   }
//
//   Future<void> signUpWithFacebook() async{
//     try {
//       var facebookLogin = new FacebookLogin();
//       var result = await facebookLogin.logIn(['email', 'public_profile']);
//
//       if(result.status == FacebookLoginStatus.loggedIn) {
//         final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
//         final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
//         print('signed in ' + user.displayName);
//         var x= user.displayName;
//         // Chuyển hướng khi đăng nhập thành công
//         Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfilePage()));
//         CoolAlert.show(
//           context: context,
//           type: CoolAlertType.success,
//           text: "Đăng kí thành công tài khoản $x"
//           "\nĐang chuyển hướng để hoàn tất hồ sơ!",
//         );
//
//         return user;
//       }
//     }catch (e) {
//       print(e.message);
//     }
//   }

  // Future<void> signUpWithMail() async {
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailTextController.text,
  //         password: passwordTextController.text
  //     );
  //     // Chuyển hướng khi đăng nhập thành công!
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfilePage()));
  //     CoolAlert.show(
  //       context: context,
  //       type: CoolAlertType.success,
  //       text: "Đăng kí thành công!"
  //           "\nĐang chuyển hướng để hoàn tất hồ sơ!",
  //     );
  //   }catch(e) {
  //     print(e.message);
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text(e.message),
  //           );
  //         }
  //     );
  //   }
  //
  // }
// }

import 'package:course_work_on_md/domain/authuser.dart';
import 'package:course_work_on_md/pages/landing.dart';
import 'package:course_work_on_md/services/auth.dart';
import 'pages/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PaulApp());
}

class PaulApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return StreamProvider<AuthUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CoolRec",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(titleMedium: TextStyle(color: Colors.black))),
        home: LandingPage(),
      ),
    );
  }
}


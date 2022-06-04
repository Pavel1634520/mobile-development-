

import 'package:course_work_on_md/domain/authuser.dart';
import 'package:course_work_on_md/pages/home.dart';
import 'package:course_work_on_md/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthUser? user = Provider.of<AuthUser?>(context);

    final bool isLoggedIn = user != null;
    return isLoggedIn ? HomePage(): RegistrationPage();
  }
}

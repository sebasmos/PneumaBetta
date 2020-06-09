import 'package:flutter/material.dart';
import 'package:pneumapp/screens/authenticate/signin.dart';
import 'package:pneumapp/screens/authenticate/register.dart';

//stful+tab: to create a state for the widget
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}

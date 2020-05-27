import 'package:flutter/material.dart';
import 'package:pneumapp/screens/authenticate/signin.dart';
//stful+tab: to create a state for the widget
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:SignIn()

    );
  }
}


import 'package:flutter/material.dart';
import 'package:pneumapp/models/user.dart';
import 'package:pneumapp/screens/wrapper.dart';
import 'package:pneumapp/services/auth.dart';
import 'package:provider/provider.dart';

// We start the PneumApp in MyApp screen with the aim of moving twards the wrapper
// the wrapper help us navigate and switch towards the log state of the user with the back/end
void main() => runApp(MyApp());

// stless + tab
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Google recommends using provider for controlling streaming
    return StreamProvider<User>.value(
      //AuthService has the Stream object we created to detect changes from firebase, which we use here as user
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

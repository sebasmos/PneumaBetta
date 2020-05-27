import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pneumapp/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  //Extract instance of the AuthService class to use signIn, Register etc functions
  final  AuthService _authInstance = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text("Welcome to PneumApp"),
      ),
        body:  Container(
              padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
              child: RaisedButton(
                child: Text("Sign in Anonimously"),
                onPressed: () async{
                  // Result is dynamic because it can be user or null and we use await since it is an asychr prcss
                  // use the service
                  dynamic result = await _authInstance.signInAnonymo();
                  if(result == null){
                    print('We couldnt sign in');
                  }else{
                    print('Signed in');
                    print(result.uid);
                  }
                },
              ),

        ) ,
    );
}
}

      
     
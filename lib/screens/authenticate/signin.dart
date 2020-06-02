import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pneumapp/services/auth.dart';

class SignIn extends StatefulWidget {
  
  // We are passing the toggleView property through authenticate.dart file itself as a param, 
  // therefore it must be passed as a widget instead of a state
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  //Extract instance of the AuthService class to use signIn, Register etc functions
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // Text field state
  String email =  '';
  String password = '';

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
              child: Form(                
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                      TextFormField(                
                        validator: (val) => val.isEmpty ? 'Enter an email': null,
                        onChanged: (val){
                             setState(()=> email = val);
                      }  
                    ),                    
                    SizedBox(height: 20.0),
                    TextFormField(                      
                      validator: (val) => val.length <6 ? 'Enter a password 6+ chars long': null,
                      obscureText: true,
                      onChanged: (val){                            
                             setState(()=> password = val);

                      },
                    ),
                    SizedBox(height:20.0),
                    RaisedButton(
                      color: Colors.blue[700],
                      child: Text(' Sign in', 
                                  style: TextStyle(color: Colors.white) 
                                  ),
                      onPressed: () async{
                          print(email);
                          print(password);
                      },
                      ),
                    RaisedButton(
                       color: Colors.transparent,
                      child: Text('Registrate aqui', 
                                  style: TextStyle(color: Colors.white) 
                                  ),
                      onPressed: () {
                        widget.toggleView();
                      },                    
                    ),
                  ],
                ),
              
              ),

        ) ,
    );
}
}

      
     
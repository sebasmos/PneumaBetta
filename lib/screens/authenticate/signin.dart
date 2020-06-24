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
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
        body:  Container(
              decoration: BoxDecoration(
                image:DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),

              padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Welcome to ",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 37),
                  ),
                 Image.asset(
                   'assets/images/LOGOFINAL.png',
                   fit: BoxFit.cover,
                   height: 88,
                 ),
                Form(                
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
                
                   Container(
                     width: size.width * 0.8,
                     child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical:20, horizontal: 40),
                                color: Colors.blue[700],
                                child: Text(' Sign in', 
                                          style: TextStyle(color: Colors.white) 
                                          ),
                                onPressed: () async{
                                if(_formKey.currentState.validate()){
                                    dynamic result = await _auth.signInWithEmailPassword(email, password);
                                  if (result == null){
                                            setState (()=> error = 'Error de inicio de secion - falla en credenciales');
                                  }
                                }       
                               },
                              ),
                     ),
                   ),
                    
                    Container(
                      margin: EdgeInsets.symmetric(vertical:10),
                      width: size.width * 0.8,
                      child: ClipRRect(                      
                                borderRadius: BorderRadius.circular(29),
                                child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical:20, horizontal: 40),
                                color: Colors.grey[700],
                                child: Text('Registrate aqui', 
                                            style: TextStyle(color: Colors.white) 
                                            ),
                                onPressed: () {
                                  widget.toggleView();
                          },                    
                        ),
                      ),
                    ),
                  ],
                ),
              
              ),

              ],),

        ) ,
      
    );
}
}

      
     
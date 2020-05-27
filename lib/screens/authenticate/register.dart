import 'package:flutter/material.dart';
import 'package:pneumapp/services/auth.dart';

class Register extends StatefulWidget {
  
  // We are passing the toggleView property through authenticate.dart file itself as a param, 
  // therefore it must be passed as a widget instead of a state
  final Function toggleView;
  Register({this.toggleView});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

// Text field state
  String email =  '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text("Register to PneumApp"),
      ),
        body:  Container(
              padding: EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                      TextFormField(onChanged: (val){
                             setState(()=> email = val);
                      }  
                    ),                    
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      onChanged: (val){                            
                             setState(()=> password = val);

                      },
                    ),
                    SizedBox(height:20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(' Register ', 
                                  style: TextStyle(color: Colors.white) 
                                  ),
                      onPressed: () async{
                          print(email);
                          print(password);
                      },                      
                      ),
                    RaisedButton(
                      color: Colors.blue[700],
                      child: Text('Login',
                                style: TextStyle(color: Colors.white)
                              ),
                      onPressed: (){
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
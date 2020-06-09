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
  final _formKey = GlobalKey<FormState>();

// Text field state
  String email =  '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
           title:Image.asset(
                'assets/LOGOFINAL.png',
                fit: BoxFit.cover,
                height: 30.0,
              ),
        centerTitle: true,      
      ),
        body:  Container(  
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,              
            ),
          ),        
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
                    //  Aqui tengo que agregar otras features del usuario / elegir bien!!
                    
                    SizedBox(height:20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(' Register ', 
                                  style: TextStyle(color: Colors.white) 
                                  ),
                      onPressed: () async{
                        // use keyform to validate form
                          if(_formKey.currentState.validate()){
                            dynamic result = await _auth.registerEmailPassword(email, password);
                            if (result == null){
                                    setState (()=> error = 'Correo incorrecto, porfavor incresar un correo valido');
                            }
                          }

                      },                      
                      ),
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
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
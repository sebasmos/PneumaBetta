import 'package:flutter/material.dart';
import 'package:pneumapp/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth =AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title:  Text('PneumApp'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
           FlatButton.icon(
              icon: Icon(Icons.person),              
              label: Text("Loggout"),
              onPressed: ()async{
                await _auth.signOutService();
              },
             )
        ],
      ),
    );
  }
}

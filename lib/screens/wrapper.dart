import 'package:flutter/material.dart';
import 'package:pneumapp/models/user.dart';
import 'package:pneumapp/screens/authenticate/authenticate.dart';
import 'package:pneumapp/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      // Use Provider to access data and track if user is signed in or out
      final user = Provider.of<User>(context);      
      if(user == null){
        return Authenticate();
      }else{
        return Home();
      }
  
  }
}
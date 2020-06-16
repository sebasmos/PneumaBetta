import 'package:firebase_auth/firebase_auth.dart';
import 'package:pneumapp/models/user.dart';

class AuthService{
  //Here inside we will create all the methods that will interact with firebase

  //create instance of auth authentication; _auth is a private property, meaning I can only use it in this file 
  final  FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user: if user is no null, then assign uid to the taken user, if it's not true then return null
  // It will depend on the registered users, if != null then we want to return uid from our model in user.dart
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid): null;
  }

  // Detect changes upcoming from auth systm in Firebase (null/object user), i.e, if a users stays signed in or logs out
  Stream<User> get user{
    return _auth.onAuthStateChanged
      .map(_userFromFirebaseUser);
  }

  //sign in anon / testing purpose only
  //'''
 // Future signInAnonymo() async{
   // try{
      //Create an object called result of type AuthResult
   //   AuthResult result = await _auth.signInAnonymously();
      // Create instance extracted from FirebaseDatabase
  //    FirebaseUser user =  result.user;
 //     return _userFromFirebaseUser(user); // returning uid
 //    }catch(e){
 //      print(e.toString());
//       return null;
  //  }
//  }

  //sign in with email and passw
Future signInWithEmailPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser userEmail = result.user;
      return _userFromFirebaseUser(userEmail);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and passw
  Future registerEmailPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser userEmail = result.user;
      return _userFromFirebaseUser(userEmail);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //SIGN OUT
  Future signOutService( ) async{
    try{
      // Use Firebase service to sign out
        return await _auth.signOut();
    }catch(e){    
      print(e.toString());
      return null;
    }
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  // uid will refer to the id document in firebase linking it with that user.
  final String uid;
  DatabaseService({this.uid});


  final CollectionReference userDataCollection = Firestore.instance.collection('user_data');
  Future updateUserData(String nombres, String apellidos, int edad, String genero )async{
    return await userDataCollection.document(uid).setData({
      // This mapping process will allow us to update data or create it from scratch 
      'nombres':nombres,
      'apellidos':apellidos,
      'edad':edad,
      'genero': genero,
    });
  }
}
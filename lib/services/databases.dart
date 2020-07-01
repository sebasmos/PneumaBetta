
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userDataCollection = Firestore.instance.collection('user_data');
  Future updateUserData(String nombres, String apellidos, int edad, String genero )async{
    return await userDataCollection.document(uid).setData({
      'nombres':nombres,
      'apellidos':apellidos,
      'edad':edad,
      'genero': genero,
    });
  }
}
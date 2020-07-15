
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pneumapp/models/user.dart';

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
  // User data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      nombres: snapshot.data['nombres'],
      apellidos: snapshot.data['apellidos'],
      edad: snapshot.data['edad'],
      genero: snapshot.data['genero'],
    );
  }

  // Get user_data stream
  Stream<UserData> get userData{
    return userDataCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}
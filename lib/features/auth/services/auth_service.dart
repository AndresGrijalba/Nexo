import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> createAccount(String email, String password) async{
    try{
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = cred.user!.uid;
      await _db.collection('users').doc(uid).set({
        'email': email,
        'name': '',
        'program': '',
        'username': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return uid;
    } on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        return 1;
      } else if (e.code == 'email-already-in-use') {
        return 2;
      } else {
        rethrow;
      }
    } catch (e){
      rethrow;
    }
  }

  Future<dynamic> singInEmailAndPassword(String email, String password) async {
    try{
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user?.uid;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        return 1;
      } else if(e.code == 'wrong-password'){
        return 2;
      } else {
        rethrow;
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

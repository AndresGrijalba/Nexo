import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createAccount(String email, String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password,
      );
      return userCredential.user?.uid;
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        return 1;
      }else if (e.code == 'email-already-in-use') {
        return 2;
      }
    } catch (e){
      print(e);
    }
  }

  Future singInEmailAndPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword( email: email, password: password);
      final a = userCredential.user;
      if(a?.uid != null){
        return a?.uid;
      }
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        return 1;
      } else if(e.code == 'wrong-password'){
        return 2;
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
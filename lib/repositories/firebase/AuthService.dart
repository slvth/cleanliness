import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final  FirebaseAuth _auth = FirebaseAuth.instance;



  FirebaseAuth getFirebaseAuth(){
      return _auth;
  }

  // Регистрация пользователя
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Вход пользователя
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String? getCurrentUserId(){
    return _auth.currentUser?.uid;
  }

  // Выход пользователя
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth getFirebaseAuth() {
    return _auth;
  }

  // Регистрация пользователя
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Вход пользователя
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');
      return null;
    } catch (e) {
      print('Unexpected error: ${e.toString()}');
      return null;
    }
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  // Выход пользователя
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Сохранение данных пользователя в Firestore
  Future<void> saveUserData(UserModel user) async {
    try {
      final fes = getCurrentUserId();
      await _firestore.collection('users').doc(getCurrentUserId()).set({
        'lastName': user.lastName,
        'firstName': user.firstName,
        'email': user.email,
        'password': user.password,
        'numberHouse': user.numberHouse,
        'numberRoom': user.numberRoom,
        'isAdmin': user.isAdmin,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUserData(UserModel user) async {
    try {
      final fes = getCurrentUserId();
      await _firestore.collection('users').doc(getCurrentUserId()).update({
        'lastName': user.lastName,
        'firstName': user.firstName,
        'email': user.email,
        'password': user.password,
        'numberHouse': user.numberHouse,
        'numberRoom': user.numberRoom,
        'isAdmin': user.isAdmin,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Получение данных пользователя из Firestore
  Future<UserModel?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          data['lastName'],
          data['firstName'],
          data['email'],
          data['password'],
          data['numberHouse'],
          data['numberRoom'],
          isAdmin: data['isAdmin'] ?? false,
        );
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
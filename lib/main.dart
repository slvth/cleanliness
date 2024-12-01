import 'dart:async';

import 'package:cleanliness_campus_app/cleanliness_app.dart';
import 'package:cleanliness_campus_app/repositories/firebase/AuthService.dart';
import 'package:cleanliness_campus_app/repositories/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() {

  runZonedGuarded(() async{
    WidgetsFlutterBinding.ensureInitialized();
    final app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    initializeDateFormatting('ru', null);

    AuthService _authService = AuthService();

    ///
    ///Создание пользователей
    ///
    /*String email = "user3@user.ru";
    String password = "123456";
    User? user = await _authService.signIn(email, password);
    if (user == null) {
      print('Sign in failed');
      // Show error message to the user
    } else {
      print('Sign in successful');
      // Navigate to the next screen
    }
    UserModel student = UserModel("Николаев", "Николай", "user3@user.ru", "123456", 1, 305);
    await _authService.saveUserData(student);*/


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String emailAdmin = "admin@admin.ru";
    String passwordAdmin = "123456";
    User? user2 = await _authService.signIn(emailAdmin, passwordAdmin);

    if (user2 == null) {
      print('Sign in failed');
      // Show error message to the user
    } else {
      prefs.setString("user_id", user2.uid);
      print('Sign in successful');
      // Navigate to the next screen
    }
    UserModel admin = UserModel("Давлетшина", "Аделина", "admin@admin.ru", "123456", 1, 401);
    await _authService.updateUserData(admin);

    runApp( CleanlinessApp());
  }, (e, st){
    print(e);
  });
}

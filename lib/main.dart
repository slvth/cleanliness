import 'package:cleanliness_campus_app/cleanliness_app.dart';
import 'package:cleanliness_campus_app/repositories/firebase/AuthService.dart';
import 'package:cleanliness_campus_app/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';
import 'router/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting('ru', null);

  AuthService _authService = AuthService();
  String email = "user@user.ru";
  String password = "123456";
  _authService.signIn(email, password);


  runApp( CleanlinessApp());
}

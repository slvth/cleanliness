import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'repositories/firebase/AuthService.dart';
import 'repositories/models/models.dart';
import 'router/route.dart';
import 'theme/theme.dart';

class CleanlinessApp extends StatefulWidget {
  const CleanlinessApp({super.key});

  @override
  State<CleanlinessApp> createState() => _CleanlinessAppState();
}

class _CleanlinessAppState extends State<CleanlinessApp> {
  final _appRouter = AppRouter();
  AuthService _authService = AuthService();
  String? userId;

  @override
  void initState() {
    super.initState();
    //_initializeAuth();
  }

  Future<void> _initializeAuth() async {
    String email = "user@user.ru";
    String password = "123456";
    User? user = await _authService.signIn(email, password);
    if (user == null) {
      print('Sign in failed');
      // Show error message to the user
    } else {
      print('Sign in successful');
      // Navigate to the next screen
    }

    /*UserModel student = UserModel("Халилов", "Василий", "user@user.ru", "123456", 1, 401);
    await _authService.updateUserData(student);
    setState(() {
      userId = _authService.getCurrentUserId();
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Чи100та в Кампусе",
      theme: defaultTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}

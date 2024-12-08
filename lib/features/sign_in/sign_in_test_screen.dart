import 'package:auto_route/annotations.dart';
import 'package:cleanliness_campus_app/features/record_list/view/record_list_admin_screen.dart';
import 'package:cleanliness_campus_app/features/record_list/view/record_list_screen.dart';
import 'package:cleanliness_campus_app/repositories/firebase/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/models/UserModel.dart';

@RoutePage()
class SignInTestScreen extends StatefulWidget {
  const SignInTestScreen({super.key});

  @override
  State<SignInTestScreen> createState() => _SignInTestScreenState();
}

class _SignInTestScreenState extends State<SignInTestScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Чистота в Кампусе"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  String email = "user3@user.ru";
                  String password = "123456";
                  User? user = await _authService.signIn(email, password);
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  if (user == null) {
                    print('Sign in failed');
                    // Show error message to the user
                  } else {
                    prefs.setString("user_id", user.uid);
                    print('Sign in successful');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecordListScreen()));
                    // Navigate to the next screen
                    UserModel student = UserModel("Николаев", "Николай",
                        "user3@user.ru", "123456", 1, 305);
                    await _authService.saveUserData(student);
                  }
                },
                child: Text(
                  'студент',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )),
            ElevatedButton(
                onPressed: () async {
                  String emailAdmin = "admin@admin.ru";
                  String passwordAdmin = "123456";
                  User? user2 =
                      await _authService.signIn(emailAdmin, passwordAdmin);

                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  if (user2 == null) {
                    print('Sign in failed');
                    // Show error message to the user
                  } else {
                    prefs.setString("user_id", user2.uid);
                    print('Sign in successful');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecordListAdminScreen()));
                    // Navigate to the next screen
                  }
                },
                child: Text(
                  'админ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}

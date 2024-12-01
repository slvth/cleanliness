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

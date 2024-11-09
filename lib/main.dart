import 'package:cleanliness_campus_app/cleanliness_app.dart';
import 'package:cleanliness_campus_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';
import 'router/route.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('ru', null);
  runApp( CleanlinessApp());
}

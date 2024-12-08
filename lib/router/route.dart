import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../features/record/view/view.dart';
import '../features/record_list/view/record_list_admin_screen.dart';
import '../features/record_list/view/record_list_detail_screen.dart';
import '../features/record_list/view/view.dart';
import '../features/sign_in/sign_in_test_screen.dart';

part 'route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: RecordListRoute.page),
        AutoRoute(page: RecordRoute.page),
        AutoRoute(page: RecordListAdminRoute.page),
        AutoRoute(page: RecordListDetailRoute.page),
        AutoRoute(page: SignInTestRoute.page, path: '/'),
      ];
}

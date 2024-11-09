import 'package:auto_route/auto_route.dart';
import '../features/record/view/view.dart';
import '../features/record_list/view/view.dart';

part 'route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: RecordListRoute.page, path: '/'),
    AutoRoute(page: RecordRoute.page),
  ];
}
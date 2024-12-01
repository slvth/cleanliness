// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'route.dart';

/// generated route for
/// [RecordListAdminScreen]
class RecordListAdminRoute extends PageRouteInfo<void> {
  const RecordListAdminRoute({List<PageRouteInfo>? children})
      : super(
          RecordListAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecordListAdminRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RecordListAdminScreen();
    },
  );
}

/// generated route for
/// [RecordListDetailScreen]
class RecordListDetailRoute extends PageRouteInfo<RecordListDetailRouteArgs> {
  RecordListDetailRoute({
    Key? key,
    required String date,
    required String time,
    List<PageRouteInfo>? children,
  }) : super(
          RecordListDetailRoute.name,
          args: RecordListDetailRouteArgs(
            key: key,
            date: date,
            time: time,
          ),
          initialChildren: children,
        );

  static const String name = 'RecordListDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecordListDetailRouteArgs>();
      return RecordListDetailScreen(
        key: args.key,
        date: args.date,
        time: args.time,
      );
    },
  );
}

class RecordListDetailRouteArgs {
  const RecordListDetailRouteArgs({
    this.key,
    required this.date,
    required this.time,
  });

  final Key? key;

  final String date;

  final String time;

  @override
  String toString() {
    return 'RecordListDetailRouteArgs{key: $key, date: $date, time: $time}';
  }
}

/// generated route for
/// [RecordListScreen]
class RecordListRoute extends PageRouteInfo<void> {
  const RecordListRoute({List<PageRouteInfo>? children})
      : super(
          RecordListRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecordListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return RecordListScreen();
    },
  );
}

/// generated route for
/// [RecordScreen]
class RecordRoute extends PageRouteInfo<void> {
  const RecordRoute({List<PageRouteInfo>? children})
      : super(
          RecordRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RecordScreen();
    },
  );
}

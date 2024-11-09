import 'package:auto_route/auto_route.dart';
import 'package:cleanliness_campus_app/router/route.dart';
import 'package:flutter/material.dart';

import '../../../repositories/models/models.dart';
import '../widgets/widgets.dart';

@RoutePage()
class RecordListScreen extends StatefulWidget {
  const RecordListScreen({super.key});

  @override
  State<RecordListScreen> createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  @override
  Widget build(BuildContext context) {
    // Создаем тестовые данные пользователей
    final List<StudentModel> users = [
      StudentModel('Иванов', 'Иван', '1234567890', 'password1',1,101),
      StudentModel('Петров', 'Петр', '9876543210', 'password2',2, 202),
      StudentModel('Сидоров', 'Сидор', '1122334455','password3', 3, 303),
    ];

    // Создаем тестовые данные записей
    final List<RecordModel> records = [
      RecordModel(
          date: '2023-10-01', time: '10:00', countMachine: 2, user: users[0]),
      RecordModel(
          date: '2023-10-02', time: '11:00', countMachine: 1, user: users[1]),
      RecordModel(
          date: '2023-10-03', time: '12:00', countMachine: 3, user: users[2]),
      RecordModel(
          date: '2023-10-04', time: '13:00', countMachine: 2, user: users[0]),
      RecordModel(
          date: '2023-10-05', time: '14:00', countMachine: 1, user: users[1]),
      RecordModel(
          date: '2023-10-06', time: '15:00', countMachine: 3, user: users[2]),
      RecordModel(
          date: '2023-10-07', time: '16:00', countMachine: 2, user: users[0]),
      RecordModel(
          date: '2023-10-08', time: '17:00', countMachine: 1, user: users[1]),
      RecordModel(
          date: '2023-10-09', time: '18:00', countMachine: 3, user: users[2]),
      RecordModel(
          date: '2023-10-10', time: '19:00', countMachine: 2, user: users[0]),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Мои бронирования')),
      body: ListView.separated(
        itemCount: records.length,
        itemBuilder: (context, i) {
          return RecordTile(record: records[i]);
        },
        separatorBuilder: (context, i) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push( RecordRoute());
        },
        backgroundColor: Colors.greenAccent,
        child:  const Icon(Icons.add),
      ),
    );
  }
}

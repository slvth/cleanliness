import 'package:flutter/material.dart';

import '../../../repositories/models/models.dart';

class RecordTile extends StatelessWidget {
  final RecordModel record;

  RecordTile({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.access_time_filled_outlined, size: 30),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Дата: ${record.date}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text('Время: ${record.time}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Корпус: ${record.user.numberHouse}',
              style: const TextStyle(fontSize: 14)),
          Text('Комната: ${record.user.numberRoom}',
              style: const TextStyle(fontSize: 14)),
          Text('Кол-во машин: ${record.countMachine}',
              style: const TextStyle(fontSize: 14)),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever_rounded, size: 30),
        onPressed: () {},
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../repositories/models/models.dart';

class RecordTile extends StatelessWidget {
  final RecordModel record;

  RecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time_filled_outlined, size: 30,),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Дата: ${record.date}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text('Время: ${record.time}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
      //trailing: Icon(Icons.arrow_forward),
    );
  }
}
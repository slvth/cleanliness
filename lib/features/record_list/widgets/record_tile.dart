import 'package:cleanliness_campus_app/repositories/firebase/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../repositories/models/models.dart';

class RecordTile extends StatefulWidget {
  final BookingModel booking;
  final UserModel? user;

  RecordTile({super.key, required this.booking, required this.user});

  @override
  State<RecordTile> createState() => _RecordTileState();
}

class _RecordTileState extends State<RecordTile> {



  @override
  void initState()  {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.access_time_filled_outlined, size: 30),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Дата: ${widget.booking.date}',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text('Время: ${widget.booking.time}',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Корпус: ${widget.user!.numberHouse}',
              style: const TextStyle(fontSize: 14)),
          Text('Комната: ${widget.user!.numberRoom}',
              style: const TextStyle(fontSize: 14)),
          Text('Кол-во машин: ${widget.booking.countMachine}',
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

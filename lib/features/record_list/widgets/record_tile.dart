import 'package:flutter/material.dart';

import '../../../repositories/models/models.dart';

class RecordTile extends StatefulWidget {
  final BookingModel booking;
  final UserModel? user;
  final VoidCallback onCancel;
  final bool isLastItem; // Флаг для определения последнего элемента

  RecordTile({
    super.key,
    required this.booking,
    required this.user,
    required this.onCancel,
    this.isLastItem = false, // По умолчанию не последний элемент
  });

  @override
  State<RecordTile> createState() => _RecordTileState();
}

class _RecordTileState extends State<RecordTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: Icon(
            Icons.local_laundry_service,
            size: 50,
            color: Color.fromRGBO(3, 142, 99, 1.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Дата: ${widget.booking.date}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text('Время: ${widget.booking.time}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
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
            icon: const Icon(Icons.delete_forever_rounded,
                size: 30, color: Color.fromRGBO(193, 19, 19, 1.0)),
            onPressed: widget.onCancel,
          ),
        ),
        if (!widget
            .isLastItem) // Добавляем Divider, если это не последний элемент
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
      ],
    );
  }
}

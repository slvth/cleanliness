import 'models.dart';

class RecordModel{
  final String date;
  final String time;
  final int countMachine;
  final UserModel user;
  RecordModel(this.countMachine, this.user, {required this.date, required this.time});

}


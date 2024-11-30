import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
   String userId;
   String date;
   String time;
   int countMachine;
  BookingModel({required this.userId, required this.date, required this.time, required this.countMachine});
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'time': time,
      'countMachine': countMachine,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      userId: map['userId'],
      date: map['date'],
      time: map['time'],
      countMachine: map['countMachine'],
    );
  }
  /*
  factory BookingModel.fromMapSimple(Map<String, dynamic> map) {
    return BookingModel(
      date: map['date'],
      time: map['time'],
    );
  }*/

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      userId: data['userId'],
      date: data['date'],
      time: data['time'],
      countMachine: data['countMachine'],
    );
  }
}
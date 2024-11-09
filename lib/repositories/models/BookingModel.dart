class BookingModel {
  final String userId;
  final String date;
  final String time;
  final int countMachine;

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
}
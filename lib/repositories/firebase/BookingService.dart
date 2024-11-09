import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Создание бронирования
  Future<void> createBooking(BookingModel booking) async {
    await _firestore.collection('bookings').add(booking.toMap());
  }

  // Получение бронирований пользователя
  Stream<QuerySnapshot> getUserBookings(String userId) {
    return _firestore.collection('bookings')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  // Отмена бронирования
  Future<void> cancelBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).delete();
  }

  // Получение всех бронирований для админа
  Stream<QuerySnapshot> getAllBookings() {
    return _firestore.collection('bookings')
        .orderBy('date', descending: false)
        .orderBy('time', descending: false)
        .snapshots();
  }

  // Получение занятых дат и времени
  Future<List<BookingModel>> getOccupiedSlots(String date) async {
    QuerySnapshot querySnapshot = await _firestore.collection('bookings')
        .where('date', isEqualTo: date)
        .get();

    return querySnapshot.docs.map((doc) => BookingModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}
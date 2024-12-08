import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Создание бронирования
  Future<void> createBooking(BookingModel booking) async {
    await _firestore.collection('bookings').add(booking.toMap());
  }

  // Получение бронирований пользователя
  Stream<QuerySnapshot> getUserBookings(String userId) {
    final now = DateTime.now();
    final currentDate = DateFormat('dd MMMM').format(now);

    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: currentDate) // Фильтруем по дате
        .orderBy('date') // Сортировка по полю 'date'
        .orderBy('time') // Сортировка по полю 'time'
        .snapshots();
  }

  // Отмена бронирования
  Future<void> cancelBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).delete();
  }

  // Получение всех бронирований для админа
  Stream<QuerySnapshot> getAllBookings() {
    return _firestore
        .collection('bookings')
        .where('date', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('date', descending: false)
        .orderBy('time', descending: false)
        .snapshots();
  }

  //
  Stream<List<DocumentSnapshot>> getAllUniqueBookings() {
    return _firestore
        .collection('bookings')
        .orderBy('date', descending: false)
        .orderBy('time', descending: false)
        .snapshots()
        .map((snapshot) {
      // Используем Set для хранения уникальных бронирований
      Set<String> uniqueKeys = Set();
      List<DocumentSnapshot> uniqueBookings = [];

      for (var doc in snapshot.docs) {
        String key = '${doc['date']}_${doc['time']}';
        if (!uniqueKeys.contains(key)) {
          uniqueKeys.add(key);
          uniqueBookings.add(doc);
        }
      }

      return uniqueBookings;
    });
  }

  Stream<List<DocumentSnapshot>> getAllBookings2() {
    final now = DateTime.now();
    final currentDate = DateFormat('dd MMMM', 'ru').format(now);

    // Устанавливаем локаль на русский язык
    initializeDateFormatting('ru', null);

    return _firestore
        .collection('bookings')
        .where('date', isGreaterThanOrEqualTo: currentDate)
        .orderBy('date', descending: false)
        .orderBy('time', descending: false)
        .snapshots()
        .transform(StreamTransformer.fromHandlers(
      handleData:
          (QuerySnapshot snapshot, EventSink<List<DocumentSnapshot>> sink) {
        // Создаем множество для хранения уникальных пар date и time
        Set<String> uniqueDatesTimes = {};
        List<DocumentSnapshot> uniqueDocuments = [];

        snapshot.docs.forEach((doc) {
          String dateTimeKey = '${doc['date']}_${doc['time']}';
          if (!uniqueDatesTimes.contains(dateTimeKey)) {
            uniqueDatesTimes.add(dateTimeKey);
            uniqueDocuments.add(doc);
          }
        });

        // Сортируем список уникальных документов по полю date и time
        uniqueDocuments.sort((a, b) {
          // Преобразуем строки дат в объекты DateTime с учетом текущего года
          DateTime dateA =
              DateFormat('dd MMMM', 'ru').parse('${a['date']} ${now.year}');
          DateTime dateB =
              DateFormat('dd MMMM', 'ru').parse('${b['date']} ${now.year}');

          int dateComparison = dateA.compareTo(dateB);
          if (dateComparison != 0) {
            return dateComparison;
          }

          // Сравниваем время, если даты равны
          return a['time'].compareTo(b['time']);
        });

        // Добавляем отсортированный список уникальных документов в поток
        sink.add(uniqueDocuments);
      },
    ));
  }

  // Получение занятых дат и времени
  /* Future<List<BookingModel>> getOccupiedSlots(String date) async {
    QuerySnapshot querySnapshot = await _firestore.collection('bookings')
        .where('date', isEqualTo: date)
        .get();

    return querySnapshot.docs.map((doc) => BookingModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
*/

  Future<List<BookingModel>> getOccupiedSlots(
      String date, int house, int floor) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('bookings')
        .where('date', isEqualTo: date)
        .get();

    List<BookingModel> bookings = querySnapshot.docs
        .map((doc) => BookingModel.fromFirestore(doc))
        .toList();

    // Фильтруем бронирования по корпусу и этажу
    List<BookingModel> filteredBookings = [];
    for (var booking in bookings) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(booking.userId).get();
      if (userDoc.exists) {
        int bookingHouse = userDoc['numberHouse'];
        int bookingFloor = int.parse(userDoc['numberRoom'].toString()[0]);
        if (bookingHouse == house && bookingFloor == floor) {
          filteredBookings.add(booking);
        }
      }
    }

    return filteredBookings;
  }
}

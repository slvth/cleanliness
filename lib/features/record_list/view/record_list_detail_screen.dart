import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RecordListDetailScreen extends StatefulWidget {
  final String date;
  final String time;
  const RecordListDetailScreen({super.key, required this.date, required this.time});

  @override
  State<RecordListDetailScreen> createState() => _RecordListDetailScreenState();
}

class _RecordListDetailScreenState extends State<RecordListDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<int, List<DocumentSnapshot>>> _loadBookings() async {
    QuerySnapshot bookingSnapshot = await _firestore
        .collection('bookings')
        .where('date', isEqualTo: widget.date)
        .where('time', isEqualTo: widget.time)
        .get();

    Map<int, List<DocumentSnapshot>> bookingsByFloor = {};

    for (var bookingDoc in bookingSnapshot.docs) {
      String userId = bookingDoc['userId'];
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        int floor = int.parse(userDoc['numberRoom'].toString()[0]);
        if (!bookingsByFloor.containsKey(floor)) {
          bookingsByFloor[floor] = [];
        }
        bookingsByFloor[floor]!.add(bookingDoc);
      }
    }

    return bookingsByFloor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.date} ${widget.time}'),
      ),
      body: FutureBuilder<Map<int, List<DocumentSnapshot>>>(
        future: _loadBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет данных для отображения'));
          }

          Map<int, List<DocumentSnapshot>> bookingsByFloor = snapshot.data!;

          return ListView.builder(
            itemCount: bookingsByFloor.length,
            itemBuilder: (context, index) {
              int floor = bookingsByFloor.keys.elementAt(index);
              List<DocumentSnapshot> bookings = bookingsByFloor[floor]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Этаж $floor',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot booking = bookings[index];
                      String userId = booking['userId'];
                      return FutureBuilder<DocumentSnapshot>(
                        future: _firestore.collection('users').doc(userId).get(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState == ConnectionState.waiting) {
                            return ListTile(
                              title: Text('Загрузка...'),
                            );
                          }

                          if (userSnapshot.hasError) {
                            return ListTile(
                              title: Text('Ошибка: ${userSnapshot.error}'),
                            );
                          }

                          if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                            return ListTile(
                              title: Text('Пользователь не найден'),
                            );
                          }

                          DocumentSnapshot userDoc = userSnapshot.data!;
                          String fullName = '${userDoc['firstName']} ${userDoc['lastName']}';
                          String roomNumber = userDoc['numberRoom'].toString();

                          return ListTile(
                            title: Text(fullName),
                            subtitle: Text('Комната: $roomNumber'),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
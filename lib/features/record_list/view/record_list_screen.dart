import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../repositories/firebase/BookingService.dart';
import '../../../repositories/models/BookingModel.dart';
import '../../record/view/record_screen.dart';

class RecordListScreen extends StatefulWidget {
  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  final BookingService _bookingService = BookingService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Мои бронирования')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _bookingService.getUserBookings(_auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Нет бронирований'));
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              BookingModel booking = BookingModel.fromMap(documents[index].data() as Map<String, dynamic>);
              return ListTile(
                title: Text(booking.date),
                subtitle: Text(booking.time),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => _bookingService.cancelBooking(documents[index].id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RecordScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
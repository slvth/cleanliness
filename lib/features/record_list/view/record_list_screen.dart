import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../repositories/firebase/AuthService.dart';
import '../../../repositories/firebase/BookingService.dart';
import '../../../repositories/models/BookingModel.dart';
import '../../../repositories/models/models.dart';
import '../../record/view/record_screen.dart';
import '../widgets/widgets.dart';

class RecordListScreen extends StatefulWidget {
  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> with RouteAware {
  final BookingService _bookingService = BookingService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<BookingModel> bookingList = [];
  List<UserModel> userList = [];
  String? userId;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    String? userId = _authService.getCurrentUserId();
    return Scaffold(
      appBar: AppBar(title: Text('Мои бронирования')),
      body: userId == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
        stream: _bookingService.getUserBookings(userId),
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
              return FutureBuilder<UserModel>(
                future: fetchUser(booking.userId),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      leading: CircularProgressIndicator(),
                      title: Text('Загрузка пользователя...'),
                    );
                  } else if (userSnapshot.hasError) {
                    return ListTile(
                      title: Text('Ошибка: ${userSnapshot.error}'),
                    );
                  } else if (!userSnapshot.hasData) {
                    return ListTile(
                      title: Text('Пользователь не найден.'),
                    );
                  } else {
                    UserModel user = userSnapshot.data!;
                    return RecordTile(
                      booking: booking,
                      user: user,
                      onCancel: () {
                        _bookingService.cancelBooking(documents[index].id);
                      },
                    );
                  }
                },
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

  Future<UserModel> fetchUser(String userId) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserModel.fromFirestore(userDoc);
  }
}
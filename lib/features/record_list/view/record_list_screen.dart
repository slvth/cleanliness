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

class _RecordListScreenState extends State<RecordListScreen>  with RouteAware{
  final BookingService _bookingService = BookingService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<BookingModel> bookingList = [];
  List<UserModel> userList = [];


  @override
  Widget build(BuildContext context) {

    AuthService _authService = AuthService();
    String? userId = _authService.getCurrentUserId();
    return Scaffold(
      appBar: AppBar(title: Text('Мои бронирования')),
      body: Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: _bookingService.getUserBookings(userId!),
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

            /*AuthService authService = AuthService();
            if(bookingList.length == documents.length){

              return ListView.builder(
                  itemCount: bookingList.length,
                  itemBuilder: (context, index) {

                    /*BookingModel booking = BookingModel.fromMap(documents[index].data() as Map<String, dynamic>);
                AuthService authService = AuthService();
                UserModel? user;
                authService.getUserData(booking.userId).then((value){
                  user = value!;
                });*/
                    BookingModel booking = bookingList[index];
                    UserModel user = userList[index];
                    return RecordTile(booking: booking, user: user);


                  });
            }
            else{
              for (var item in documents) {
                BookingModel booking = BookingModel.fromMap(
                    item.data() as Map<String, dynamic>);
                UserModel user;
                authService.getUserData(booking.userId).then((value){
                  userList.add(value!);
                  bookingList.add(booking);
                });
              }
            }
            return const Center(child: CircularProgressIndicator());*/

            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {

                  BookingModel booking = BookingModel.fromMap(documents[index].data() as Map<String, dynamic>);
                AuthService authService = AuthService();
                UserModel? user;
                authService.getUserData(booking.userId).then((value){
                  user = value!;
                });
                  return ListTile(
                    title: Text(booking.date),
                    subtitle: Text(booking.time),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () => _bookingService.cancelBooking(documents[index].id),
                    ),
                  );
                });
          }
        ),
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
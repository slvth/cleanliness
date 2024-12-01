import 'package:auto_route/annotations.dart';
import 'package:cleanliness_campus_app/features/record_list/view/record_list_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/firebase/BookingService.dart';
import '../../../repositories/models/models.dart';
import '../widgets/record_tile_admin.dart';

@RoutePage()
class RecordListAdminScreen extends StatefulWidget {
  const RecordListAdminScreen({super.key});

  @override
  State<RecordListAdminScreen> createState() => _RecordListAdminScreenState();
}

class _RecordListAdminScreenState extends State<RecordListAdminScreen> {
  final BookingService _bookingService = BookingService();
  String? userId ="";
  late List<RecordModel> records;

  @override
  void initState(){
    super.initState();
    getUserId();
  }

   void getUserId () async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     userId = prefs.getString("user_id");
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Бронирования')),
      body: userId == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<List<DocumentSnapshot>>(stream: _bookingService.getAllBookings2(), builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Нет бронирований'));
        }
        List<DocumentSnapshot> documents = snapshot.data!;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            BookingModel booking = BookingModel.fromMapSimple(documents[index].data() as Map<String, dynamic>);
            return ListTile(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecordListDetailScreen(date: booking.date, time: booking.time)));
            },
              title: Text(booking.date),
              subtitle: Text(booking.time),);
          },
        );
      })
    );
  }
}

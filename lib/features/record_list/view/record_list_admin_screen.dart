import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/firebase/BookingService.dart';
import '../../../repositories/models/models.dart';
import '../widgets/record_tile_admin.dart';

class RecordListAdminScreen extends StatefulWidget {
  const RecordListAdminScreen({super.key});

  @override
  State<RecordListAdminScreen> createState() => _RecordListAdminScreenState();
}

class _RecordListAdminScreenState extends State<RecordListAdminScreen> {
  final BookingService _bookingService = BookingService();
  String? userId;
  late List<RecordModel> records;


  @override
  void initState() async{
    super.initState();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Бронирования')),
      body: userId == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(stream: _bookingService.getAllBookings(), builder: (context, snapshot){
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
            return ListTile();
          },
        );
      })
    );
  }
}
